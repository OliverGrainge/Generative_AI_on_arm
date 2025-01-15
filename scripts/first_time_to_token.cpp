#include <chrono>
#include "llama.h"  // or whichever header you are using for inference

// ... [initialize model, context, etc.]

auto start_time = std::chrono::high_resolution_clock::now();

// Begin inference loop or call:
while (/* condition for generating tokens */) {
    // Evaluate the model (e.g., llama_eval or llama_sample_prompt, etc.)
    llama_eval(ctx, tokens + token_count, n_past, n_batch, n_threads);
    
    // Process output tokens from llama_eval
    // Typically, you iterate over the newly generated tokens. For the first token:
    if ( /* first token just generated */ ) {
        auto first_token_time = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(first_token_time - start_time).count();
        std::cout << "Time to first token: " << duration << "ms\n";
        
        // Optionally break out if only measuring first token
        break;
    }
    
    // Update token_count, n_past, etc., for next batch...
}
