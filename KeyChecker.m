
#import <Foundation/Foundation.h>
#import <mach-o/dyld.h>
#import "api.h"

// Pointer MSHookFunction dari substrate/substitute
extern void MSHookFunction(void *symbol, void *replace, void **result);

void (*orig_initMenu)(void);

void my_initMenu(void) {
[APIKeyServer checkKeyValidWithCompletion:^(BOOL isValid) {
if (isValid && orig_initMenu) {
orig_initMenu(); // Jalankan menu asli jika key valid
}
}];
}

__attribute__((constructor))
static void initialize(void) {
[APIKeyServer setApiToken:@"F7fgqwpqmMGZdN03UkvyDTjjI+fuA1z0zQ2AcH+umwSNi0nwolEDstMEOrlEsxHyiUUj4M/7hRwYD6VApIf9c3kkgQYy6dWE/B69+eT5F0g="]; // Masukkan token V3 kamu

uintptr_t baseAddr = _dyld_get_image_vmaddr_slide(0);
uintptr_t targetOffset = 0x2bd10; // Offset dari Ghidra[span_0](start_span)[span_0](end_span)

MSHookFunction((void *)(baseAddr + targetOffset), (void *)my_initMenu, (void **)&orig_initMenu);
}

