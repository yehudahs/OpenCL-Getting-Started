/* OpenCL built-in library: hypot()

   Copyright (c) 2011 Erik Schnetter <eschnetter@perimeterinstitute.ca>
                      Perimeter Institute for Theoretical Physics

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

#include "hsail_templates.h"


float _cl_builtin_hypotf(float x, float y)
{
    float a = fabs(x);
    float b = fabs(y);
    float n = fmin(a, b);
    float m = fmax(a, b);
    if (m == 0.0f)
        return 0.0f;
    float d = n / m;
    return m * sqrt(fma(d, d, 1.0f));
}

double _cl_builtin_hypot(double x, double y)
{
    double a = fabs(x);
    double b = fabs(y);
    double n = fmin(a, b);
    double m = fmax(a, b);
    if (m == 0.0)
        return 0.0;
    double d = n / m;
    return m * sqrt(fma(d, d, 1.0));
}

IMPLEMENT_EXPR_ALL(hypot, V_VV, _cl_builtin_hypotf(a, b), _cl_builtin_hypot(a, b))
