/* OpenCL runtime library: clReleaseDevice()

   Copyright (c) 2011 Pekka Jääskeläinen / TUT
   
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

#include "pocl_cl.h"

CL_API_ENTRY cl_int CL_API_CALL
POname(clReleaseDevice)(cl_device_id device) CL_API_SUFFIX__VERSION_1_2 
{
  POCL_RETURN_ERROR_COND ((device == NULL), CL_INVALID_DEVICE);

  if (device->parent_device == NULL)
    return CL_SUCCESS;

  int new_refcount;
  POCL_RELEASE_OBJECT (device, new_refcount);

  if (new_refcount == 0)
    {
      POCL_DESTROY_OBJECT (device);
      POCL_MEM_FREE (device->partition_type);
      POCL_MSG_PRINT_REFCOUNTS ("Free Device %p\n", device);
      POCL_MEM_FREE (device);
    }
  else
    POCL_MSG_PRINT_REFCOUNTS ("Release Device %p : %u\n", device,
                              device->pocl_refcount);

  return CL_SUCCESS;
}
POsym(clReleaseDevice)
