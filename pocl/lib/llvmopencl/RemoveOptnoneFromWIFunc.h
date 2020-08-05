// Header for RemoveOptnoneFromWIFunc, an LLVM pass to remove optnone keyword
//
// Copyright (c) 2017 Michal Babej / TUT
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

#ifndef _POCL_REMOVE_OPTNONE_H
#define _POCL_REMOVE_OPTNONE_H

#include "config.h"

#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/CommandLine.h"

namespace pocl {
class RemoveOptnoneFromWIFunc : public llvm::FunctionPass {
public:
  static char ID;

  RemoveOptnoneFromWIFunc();
  virtual ~RemoveOptnoneFromWIFunc(){};

  void getAnalysisUsage(llvm::AnalysisUsage &AU) const { AU.setPreservesAll(); }

  virtual bool runOnFunction(llvm::Function &F);
};
}

#endif
