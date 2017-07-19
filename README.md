# Basic Double Blind Review Checker for a PDF

Goal: Ferret out double blind review violations before you submit. This is what the PC will be looking for anyways.

usage:

  bash check.sh yourpdf.pdf

Example run:

  hindle1@st-francis:~/projects/pubs$ bash ~/projects/dbr-check/check.sh hindle2016EMSE-bugdedup.pdf
  # processing hindle2016EMSE-bugdedup.pdf
  # hindle2016EMSE-bugdedup.pdf.txt is created
  # There should be no emails, unless from data
  hindle2016EMSE-bugdedup.pdf:	E-mail: abram.hindle@ualberta.ca
  hindle2016EMSE-bugdedup.pdf:	E-mail: alipour1@ualberta.ca
  hindle2016EMSE-bugdedup.pdf:	E-mail: stroulia@ualberta.ca
  # Acknowledgements should be omitted or blinded
  hindle2016EMSE-bugdedup.pdf:	7 Acknowledgments
  # self citation should not use the language of ownership (plausible deniability)
  # Warning: Lots of false positives
  hindle2016EMSE-bugdedup.pdf:	bug reports. Intuitively, the thesis of our work is that bug reports should not
  hindle2016EMSE-bugdedup.pdf:	et al. [30]). From a methodological perspective, our work argues that the Mean
  hindle2016EMSE-bugdedup.pdf:	As indicated in Table 2, in our study the bug reports include the following fields: description, summary, status, component, priority, type, version,
  hindle2016EMSE-bugdedup.pdf:	of the retrieval process to be. In our study, we evaluate the sorted list of
  hindle2016EMSE-bugdedup.pdf:	As demonstrated in our previous work [2], classification algorithms can
  hindle2016EMSE-bugdedup.pdf:	our work
  hindle2016EMSE-bugdedup.pdf:	our work
  hindle2016EMSE-bugdedup.pdf:	our study
  hindle2016EMSE-bugdedup.pdf:	our study
  hindle2016EMSE-bugdedup.pdf:	our previous

# Requirements

* GNU Grep
* GNU Bash
* Poppler-utils: https://poppler.freedesktop.org/
  * Windows http://blog.alivate.com.au/poppler-windows/
  * OSX http://macappstore.org/poppler/
  * Ubuntu apt-get install poppler-utils


