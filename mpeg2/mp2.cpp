#include <cstdio>
#include <cstdint>

extern "C" {
#include <mpeg2dec/mpeg2.h>
}

int main()
{
	mpeg2dec_t *_mpegDecoder;
	_mpegDecoder = mpeg2_init();
	if (!_mpegDecoder) {
		fprintf(stderr, "Failed to init decoder\n");
	}
	mpeg2_close(_mpegDecoder);
	return 0;
}
