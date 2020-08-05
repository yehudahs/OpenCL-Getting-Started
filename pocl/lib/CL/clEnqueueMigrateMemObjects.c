/* OpenCL runtime library: clEnqueueMigrateMemObjects()

   Copyright (c) 2013 Ville Korhonen / Tampere Univ. of Tech.
   
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
#include "pocl_util.h"
#include <string.h>

CL_API_ENTRY cl_int CL_API_CALL
POname(clEnqueueMigrateMemObjects) (cl_command_queue command_queue,
                                    cl_uint num_mem_objects,
                                    const cl_mem *mem_objects,
                                    cl_mem_migration_flags flags,
                                    cl_uint num_events_in_wait_list,
                                    const cl_event *event_wait_list,
                                    cl_event *event)CL_API_SUFFIX__VERSION_1_0
{
  unsigned i;
  int errcode;
  _cl_command_node *cmd = NULL;
  cl_mem *new_mem_objects = NULL;

  POCL_RETURN_ERROR_COND((command_queue == NULL), CL_INVALID_COMMAND_QUEUE);
  POCL_RETURN_ERROR_COND((num_mem_objects == 0), CL_INVALID_VALUE);
  POCL_RETURN_ERROR_COND((mem_objects == NULL), CL_INVALID_VALUE);

  cl_mem_migration_flags invalid_flags =
     ~(CL_MIGRATE_MEM_OBJECT_CONTENT_UNDEFINED | CL_MIGRATE_MEM_OBJECT_HOST);
  POCL_RETURN_ERROR_COND (((flags != 0) && (flags & invalid_flags)),
                          CL_INVALID_VALUE);
  /* TODO check if it's OK to ignore flags. */

  errcode = pocl_check_event_wait_list (command_queue, num_events_in_wait_list,
                                        event_wait_list);
  if (errcode != CL_SUCCESS)
    return errcode;

  new_mem_objects = calloc (sizeof (cl_mem), num_mem_objects);

  for (i = 0; i < num_mem_objects; ++i)
    {
      POCL_GOTO_ERROR_COND ((mem_objects[i] == NULL), CL_INVALID_MEM_OBJECT);

      POCL_GOTO_ERROR_COND (
          (mem_objects[i]->context != command_queue->context),
          CL_INVALID_CONTEXT);

      if (mem_objects[i]->parent == NULL)
        new_mem_objects[i] = mem_objects[i];
      else
        new_mem_objects[i] = mem_objects[i]->parent;

      IMAGE1D_TO_BUFFER (new_mem_objects[i]);
    }

  errcode = pocl_create_command (&cmd, command_queue,
                                 CL_COMMAND_MIGRATE_MEM_OBJECTS, event,
                                 num_events_in_wait_list, event_wait_list,
                                 num_mem_objects, new_mem_objects);

  if (errcode != CL_SUCCESS)
    goto ERROR;

  cmd->command.migrate.data = command_queue->device->data;
  cmd->command.migrate.num_mem_objects = num_mem_objects;
  cmd->command.migrate.mem_objects = new_mem_objects;
  cmd->command.migrate.source_devices = malloc
    (num_mem_objects * sizeof (cl_device_id));

  for (i = 0; i < num_mem_objects; ++i)
    {
      POname (clRetainMemObject) (new_mem_objects[i]);

      cmd->command.migrate.source_devices[i]
          = new_mem_objects[i]->owning_device;

      new_mem_objects[i]->owning_device = command_queue->device;
    }

  pocl_command_enqueue (command_queue, cmd);

  return CL_SUCCESS;

ERROR:
  POCL_MEM_FREE (new_mem_objects);
  free (cmd);
  free (event);
  return errcode;
}
POsym(clEnqueueMigrateMemObjects)
