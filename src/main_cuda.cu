#include "../include/main_cuda.h"
#include "../include/add.h"

int main(void)
{
    int N = 1 << 20; // 1M elements

    float *x = nullptr; // new float[N];
    float *y = nullptr; // new float[N];
    cudaMallocManaged(&x, N*sizeof(float));
    cudaMallocManaged(&y, N*sizeof(float));


    // initialize x and y arrays on the host
    for (int i = 0; i < N; i++)
    {
        x[i] = 1.0f;
        y[i] = 2.0f;
    }

    // Run kernel on 1M elements on the GPU
    int blockSize = 128;
    int numBlocks = (N + blockSize - 1) / blockSize;

    // read more on Unified Memory: https://developer.nvidia.com/blog/unified-memory-cuda-beginners/
    // problem with unified memory is, initializing it on CPU moves pages on CPU
    // then accessing on GPU makes a lot of fetch misses.
    // one solution to this is force-prefetching data, like this.


    // Prefetch the data to the GPU
    int device = -1;
    cudaGetDevice(&device);
    cudaMemPrefetchAsync(x, N*sizeof(float), device, NULL);
    cudaMemPrefetchAsync(y, N*sizeof(float), device, NULL);
    add<<<numBlocks, blockSize>>>(N, x, y);

    cudaDeviceSynchronize();
    // Check for errors (all values should be 3.0f)
    float maxError = 0.0f;
    for (int i = 0; i < N; i++)
        maxError = fmax(maxError, fabs(y[i] - 3.0f));
    std::cout << "Max error: " << maxError << std::endl;

    // Free memory
    cudaFree(x);
    cudaFree(y);

    return maxError;
}