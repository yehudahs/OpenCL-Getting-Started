#include "sleef_cl.h"

_CL_OVERLOADABLE
float
_cl_hypot (float x, float y)
{

#ifdef MAX_PRECISION
  return Sleef_hypotf_u05 (x, y);
#else
  return Sleef_hypotf_u35 (x, y);
#endif
}

_CL_OVERLOADABLE
float2
_cl_hypot (float2 x, float2 y)
{

  float lo = _cl_hypot (x.lo, y.lo);
  float hi = _cl_hypot (x.hi, y.hi);
  return (float2) (lo, hi);
}

_CL_OVERLOADABLE
float4 _cl_hypot (float4, float4);

_CL_OVERLOADABLE
float3
_cl_hypot (float3 x, float3 y)
{

  float4 x_3to4 = (float4) (x, (float)0);
  float4 y_3to4 = (float4) (y, (float)0);

  float4 r = _cl_hypot (x_3to4, y_3to4);
  return r.xyz;
}

_CL_OVERLOADABLE
float4
_cl_hypot (float4 x, float4 y)
{

#if defined(SLEEF_VEC_128_AVAILABLE)

#ifdef MAX_PRECISION
  return Sleef_hypotf4_u05 (x, y);
#else
  return Sleef_hypotf4_u35 (x, y);
#endif

#else

  float2 lo = _cl_hypot (x.lo, y.lo);
  float2 hi = _cl_hypot (x.hi, y.hi);
  return (float4) (lo, hi);

#endif
}

_CL_OVERLOADABLE
float8
_cl_hypot (float8 x, float8 y)
{

#if defined(SLEEF_VEC_256_AVAILABLE)

#ifdef MAX_PRECISION
  return Sleef_hypotf8_u05 (x, y);
#else
  return Sleef_hypotf8_u35 (x, y);
#endif

#else

  float4 lo = _cl_hypot (x.lo, y.lo);
  float4 hi = _cl_hypot (x.hi, y.hi);
  return (float8) (lo, hi);

#endif
}

_CL_OVERLOADABLE
float16
_cl_hypot (float16 x, float16 y)
{

#if defined(SLEEF_VEC_512_AVAILABLE)

#ifdef MAX_PRECISION
  return Sleef_hypotf16_u05 (x, y);
#else
  return Sleef_hypotf16_u35 (x, y);
#endif

#else

  float8 lo = _cl_hypot (x.lo, y.lo);
  float8 hi = _cl_hypot (x.hi, y.hi);
  return (float16) (lo, hi);

#endif
}

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double
_cl_hypot (double x, double y)
{

#ifdef MAX_PRECISION
  return Sleef_hypot_u05 (x, y);
#else
  return Sleef_hypot_u35 (x, y);
#endif
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double2
_cl_hypot (double2 x, double2 y)
{

#if defined(SLEEF_VEC_128_AVAILABLE) && defined(SLEEF_DOUBLE_VEC_AVAILABLE)

#ifdef MAX_PRECISION
  return Sleef_hypotd2_u05 (x, y);
#else
  return Sleef_hypotd2_u35 (x, y);
#endif

#else

  double lo = _cl_hypot (x.lo, y.lo);
  double hi = _cl_hypot (x.hi, y.hi);
  return (double2) (lo, hi);

#endif
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double4 _cl_hypot (double4, double4);

_CL_OVERLOADABLE
double3
_cl_hypot (double3 x, double3 y)
{

  double4 x_3to4 = (double4) (x, (double)0);
  double4 y_3to4 = (double4) (y, (double)0);

  double4 r = _cl_hypot (x_3to4, y_3to4);
  return r.xyz;
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double4
_cl_hypot (double4 x, double4 y)
{

#if defined(SLEEF_VEC_256_AVAILABLE) && defined(SLEEF_DOUBLE_VEC_AVAILABLE)

#ifdef MAX_PRECISION
  return Sleef_hypotd4_u05 (x, y);
#else
  return Sleef_hypotd4_u35 (x, y);
#endif

#else

  double2 lo = _cl_hypot (x.lo, y.lo);
  double2 hi = _cl_hypot (x.hi, y.hi);
  return (double4) (lo, hi);

#endif
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double8
_cl_hypot (double8 x, double8 y)
{

#if defined(SLEEF_VEC_512_AVAILABLE) && defined(SLEEF_DOUBLE_VEC_AVAILABLE)

#ifdef MAX_PRECISION
  return Sleef_hypotd8_u05 (x, y);
#else
  return Sleef_hypotd8_u35 (x, y);
#endif

#else

  double4 lo = _cl_hypot (x.lo, y.lo);
  double4 hi = _cl_hypot (x.hi, y.hi);
  return (double8) (lo, hi);

#endif
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double16
_cl_hypot (double16 x, double16 y)
{

  double8 lo = _cl_hypot (x.lo, y.lo);
  double8 hi = _cl_hypot (x.hi, y.hi);
  return (double16) (lo, hi);
}

#endif /* cl_khr_fp64 */
