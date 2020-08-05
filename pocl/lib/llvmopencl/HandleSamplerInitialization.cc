// LLVM function pass to convert the sampler initializer calls to a target
// desired format
//
// Copyright (c) 2017 Pekka Jääskeläinen / TUT
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#include <set>
#include <iostream>

#include "CompilerWarnings.h"
IGNORE_COMPILER_WARNING("-Wunused-parameter")

#include "pocl.h"
#include "HandleSamplerInitialization.h"
#include "Workgroup.h"
#include "VariableUniformityAnalysis.h"

#include <llvm/IR/Instructions.h>
#include <llvm/IR/IRBuilder.h>

POP_COMPILER_DIAGS

using namespace llvm;

namespace {
  static
  RegisterPass<pocl::HandleSamplerInitialization>
  X("handle-samplers",
    "Handles sampler initialization calls.");
}

namespace pocl {

char HandleSamplerInitialization::ID = 0;

HandleSamplerInitialization::HandleSamplerInitialization() : FunctionPass(ID) {
}

bool
HandleSamplerInitialization::runOnFunction(Function &F) {

  // Collect the sampler init calls to handle first, do not remove them
  // instantly as it'd invalidate the iterators.
  std::set<CallInst*> Calls;

  for (Function::iterator I = F.begin(), E = F.end(); I != E; ++I) {
    for (BasicBlock::iterator BI = I->begin(), BE = I->end(); BI != BE; ++BI) {
      Instruction *Instr = dyn_cast<Instruction>(BI);
      if (!llvm::isa<CallInst>(Instr)) continue;
      CallInst *CallInstr = dyn_cast<CallInst>(Instr);
      if (CallInstr->getCalledFunction() != nullptr &&
	  CallInstr->getCalledFunction()->getName() ==
	  "__translate_sampler_initializer") {
	Calls.insert(CallInstr);
      }
    }
  }

  bool Changed = false;
  for (auto C : Calls) {
    llvm::IRBuilder<> Builder(C);

    // get the type of the return value of __translate_sampler
    // this may not always be opencl.sampler_t, it could be a remapped type.
#ifdef LLVM_OLDER_THAN_11_0
    Type *type = C->getCalledValue()->getType();
#else
    Type *type = C->getCalledOperand()->getType();
#endif
    PointerType *pt = dyn_cast<PointerType>(type);
    FunctionType *ft = dyn_cast<FunctionType>(pt->getPointerElementType());
    Type *rettype = ft->getReturnType();

    ConstantInt *SamplerValue = dyn_cast<ConstantInt>(C->arg_begin()->get());

    IntegerType *it;
    if (F.getParent()->getDataLayout().getPointerSizeInBits() == 64)
      it = Builder.getInt64Ty();
    else
      it = Builder.getInt32Ty();
    // cast the sampler value to intptr_t
    Constant *sampler = ConstantInt::get(it, SamplerValue->getZExtValue());
    // then bitcast it to return value (opencl.sampler_t*)
    Value *val = Builder.CreateBitOrPointerCast(sampler, rettype);

    C->replaceAllUsesWith(val);
    C->eraseFromParent();
    Changed = true;
  }

  return Changed;
}

void
HandleSamplerInitialization::getAnalysisUsage(AnalysisUsage &AU) const {
  AU.addPreserved<pocl::VariableUniformityAnalysis>();
}

}
