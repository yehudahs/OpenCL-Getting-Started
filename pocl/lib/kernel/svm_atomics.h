/* OpenCL built-in library: OpenCL 2.0 Atomics (C11 subset) prototypes

   Copyright (c) 2015 Michal Babej / Tampere University of Technology

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
   THE SOFTWARE.
*/


#if !defined(Q)

#  define Q __global
#  define QUAL(f) f ## __global
#  include "svm_atomics.h"
#  undef Q
#  undef QUAL

#  define Q __local
#  define QUAL(f) f ## __local
#  include "svm_atomics.h"
#  undef Q
#  undef QUAL

#elif !defined(ATOMIC_TYPE)

bool _CL_OVERLOADABLE QUAL(pocl_atomic_flag_test_and_set) ( volatile Q atomic_flag  *object ,
  memory_order order,
  memory_scope scope);

void _CL_OVERLOADABLE QUAL(pocl_atomic_flag_clear) ( volatile Q atomic_flag  *object ,
  memory_order order,
  memory_scope scope);

#  define ATOMIC_TYPE atomic_int
#  define NONATOMIC_TYPE int
#  include "svm_atomics.h"
#  undef ATOMIC_TYPE
#  undef NONATOMIC_TYPE

#  define ATOMIC_TYPE atomic_uint
#  define NONATOMIC_TYPE uint
#  include "svm_atomics.h"
#  undef ATOMIC_TYPE
#  undef NONATOMIC_TYPE

#  define ATOMIC_TYPE atomic_float
#  define NONATOMIC_TYPE float
#  define NON_INTEGER
#  include "svm_atomics.h"
#  undef NON_INTEGER
#  undef ATOMIC_TYPE
#  undef NONATOMIC_TYPE

#if defined(cl_khr_int64_base_atomics) && defined(cl_khr_int64_extended_atomics)
#pragma OPENCL EXTENSION cl_khr_int64_base_atomics : enable
#pragma OPENCL EXTENSION cl_khr_int64_extended_atomics : enable

#  define ATOMIC_TYPE atomic_long
#  define NONATOMIC_TYPE long
#  include "svm_atomics.h"
#  undef ATOMIC_TYPE
#  undef NONATOMIC_TYPE

#  define ATOMIC_TYPE atomic_ulong
#  define NONATOMIC_TYPE ulong
#  include "svm_atomics.h"
#  undef ATOMIC_TYPE
#  undef NONATOMIC_TYPE

#endif

#ifdef cl_khr_fp64
#pragma OPENCL EXTENSION cl_khr_fp64 : enable

#  define ATOMIC_TYPE atomic_double
#  define NONATOMIC_TYPE double
#  define NON_INTEGER
#  include "svm_atomics.h"
#  undef NON_INTEGER
#  undef ATOMIC_TYPE
#  undef NONATOMIC_TYPE

#endif

#else

_CL_OVERLOADABLE void QUAL(pocl_atomic_store)( volatile Q ATOMIC_TYPE  *object,
                              NONATOMIC_TYPE  desired,
                              memory_order order,
                              memory_scope scope);

_CL_OVERLOADABLE NONATOMIC_TYPE QUAL(pocl_atomic_load) ( volatile Q ATOMIC_TYPE  *object,
                                        memory_order order,
                                        memory_scope scope);

_CL_OVERLOADABLE NONATOMIC_TYPE QUAL(pocl_atomic_exchange) ( volatile Q ATOMIC_TYPE  *object,
                                            NONATOMIC_TYPE  desired,
                                            memory_order order,
                                            memory_scope scope);

bool _CL_OVERLOADABLE QUAL(pocl_atomic_compare_exchange_strong) ( volatile Q ATOMIC_TYPE  *object,
  private NONATOMIC_TYPE  *expected,
  NONATOMIC_TYPE  desired,
  memory_order success,
  memory_order failure,
  memory_scope scope);

bool _CL_OVERLOADABLE QUAL(pocl_atomic_compare_exchange_weak) ( volatile Q ATOMIC_TYPE  *object,
  private NONATOMIC_TYPE  *expected,
  NONATOMIC_TYPE  desired,
  memory_order success,
  memory_order failure,
  memory_scope scope);

#ifndef NON_INTEGER

NONATOMIC_TYPE _CL_OVERLOADABLE QUAL(pocl_atomic_fetch_add) ( volatile Q ATOMIC_TYPE  *object,
  NONATOMIC_TYPE  operand,
  memory_order order,
  memory_scope scope);

NONATOMIC_TYPE _CL_OVERLOADABLE QUAL(pocl_atomic_fetch_sub) ( volatile Q ATOMIC_TYPE  *object,
  NONATOMIC_TYPE  operand,
  memory_order order,
  memory_scope scope);

NONATOMIC_TYPE _CL_OVERLOADABLE QUAL(pocl_atomic_fetch_or) ( volatile Q ATOMIC_TYPE  *object,
  NONATOMIC_TYPE  operand,
  memory_order order,
  memory_scope scope);

NONATOMIC_TYPE _CL_OVERLOADABLE QUAL(pocl_atomic_fetch_xor) ( volatile Q ATOMIC_TYPE  *object,
  NONATOMIC_TYPE  operand,
  memory_order order,
  memory_scope scope);

NONATOMIC_TYPE _CL_OVERLOADABLE QUAL(pocl_atomic_fetch_and) ( volatile Q ATOMIC_TYPE  *object,
  NONATOMIC_TYPE  operand,
  memory_order order,
  memory_scope scope);

NONATOMIC_TYPE _CL_OVERLOADABLE QUAL(pocl_atomic_fetch_min) ( volatile Q ATOMIC_TYPE  *object,
  NONATOMIC_TYPE  operand,
  memory_order order,
  memory_scope scope);

NONATOMIC_TYPE _CL_OVERLOADABLE QUAL(pocl_atomic_fetch_max) ( volatile Q ATOMIC_TYPE  *object,
  NONATOMIC_TYPE  operand,
  memory_order order,
  memory_scope scope);

#endif

#endif
