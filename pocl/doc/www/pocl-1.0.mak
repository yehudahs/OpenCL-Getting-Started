<%!
        sub_page = "Portable Computing Language (pocl) v1.0 released"
%>
<%inherit file="basic_page.makt" />

<h1>December 2017: pocl v1.0 released</h2>

<h2>Release highlights</h2>

<ul>
<li>Support for LLVM/Clang 5.0 and 4.0.</li>
<li>Support for NVIDIA GPUs via a new CUDA backend (currently experimental)</li>
<li>Most of the OpenCL 1.2 standard conformance tests pass with the CPU
  backend.  There are some caveats though - see the documentation.</li>
</ul>
</p>

<p>Please note that there's now an official pocl maintenance policy in place.
<a href="http://portablecl.org/docs/html/maintainer-policy.html">This text</a>
describes the policy and how you can get your favourite project
that uses OpenCL to remain regression free in the future pocl releases.</p>

<p>We are looking for active maintainers to look after the ARM(64) and MacOS
ports. If you are interested in helping to keep pocl working well on these
platforms, please let us know!</p>

<h2>Acknowledgements</h2>

<p>Most of the code that landed to the pocl code base during this release
cycle was produced for the needs of research funded by various sources.
The Customized Parallel Computing research group of Tampere
University of Technology (Finland) likes to thank the Academy of Finland
(funding decision 297548), Finnish Funding Agency for Technology and Innovation
(funding decision 40142/14, FiDiPro-StreamPro), ARTEMIS joint undertaking
under grant agreement no 621439 (ALMARVI) and HSA Foundation.</p>

<p><a href="download.html">Download</a>.</p>
