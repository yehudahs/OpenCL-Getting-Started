define i32 @_Z10atomic_andPU3AS1Vii(i32 addrspace(1)* %ptr, i32 %val) {
entry:
  %0 = atomicrmw and i32 addrspace(1)* %ptr, i32 %val monotonic
  ret i32 %0
}

define i32 @_Z10atomic_andPU3AS1Vjj(i32 addrspace(1)* %ptr, i32 %val) {
entry:
  %0 = atomicrmw and i32 addrspace(1)* %ptr, i32 %val monotonic
  ret i32 %0
}

define i32 @_Z10atomic_andPU3AS3Vii(i32 addrspace(3)* %ptr, i32 %val) {
entry:
  %0 = atomicrmw and i32 addrspace(3)* %ptr, i32 %val monotonic
  ret i32 %0
}

define i32 @_Z10atomic_andPU3AS3Vjj(i32 addrspace(3)* %ptr, i32 %val) {
entry:
  %0 = atomicrmw and i32 addrspace(3)* %ptr, i32 %val monotonic
  ret i32 %0
}

define i64 @_Z10atomic_andPU3AS1Vll(i64 addrspace(1)* %ptr, i64 %val) {
entry:
  %0 = atomicrmw and i64 addrspace(1)* %ptr, i64 %val monotonic
  ret i64 %0
}

define i64 @_Z10atomic_andPU3AS1Vmm(i64 addrspace(1)* %ptr, i64 %val) {
entry:
  %0 = atomicrmw and i64 addrspace(1)* %ptr, i64 %val monotonic
  ret i64 %0
}

define i64 @_Z10atomic_andPU3AS3Vll(i64 addrspace(3)* %ptr, i64 %val) {
entry:
  %0 = atomicrmw and i64 addrspace(3)* %ptr, i64 %val monotonic
  ret i64 %0
}

define i64 @_Z10atomic_andPU3AS3Vmm(i64 addrspace(3)* %ptr, i64 %val) {
entry:
  %0 = atomicrmw and i64 addrspace(3)* %ptr, i64 %val monotonic
  ret i64 %0
}
