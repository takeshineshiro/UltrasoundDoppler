HEADERS     += $$PWD/kiss_fft.h \
               $$PWD/kiss_fftr.h
               $$PWD/_kiss_fft_guts.h
SOURCES     += $$PWD/kiss_fft.c \
               $$PWD/kiss_fftr.c
DEPENDPATH  += $$PWD
INCLUDEPATH += $$PWD
message(Project files are in $$PWD)

# How To USE
#
# kiss_fft_cpx cin[samples];
# kiss_fft_cpx cout[samples];
#
# kiss_fft_cfg fftcfg = kiss_fft_alloc(samples, 0, 0, 0);
# kiss_fft_scalar zero;
# memset(&zero, 0, sizeof(zero));
#
# fill cin array
# cin[i].r = data[i];
# cin[i].i = zero;
#
# kiss_fft(fftcfg, cin, cout);
