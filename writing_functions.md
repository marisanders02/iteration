Writing Functions
================
Mari Sanders
2024-10-24

## Writing Functions

Finding z-scores.

``` r
x_vec <- rnorm(n = 25, mean = 10, sd = 3.5)

(x_vec - mean(x_vec))/sd(x_vec)
```

    ##  [1] -0.83687228  0.01576465 -1.05703126  1.50152998  0.16928872 -1.04107494
    ##  [7]  0.33550276  0.59957343  0.42849461 -0.49894708  1.41364561  0.23279252
    ## [13] -0.83138529 -2.50852027  1.00648110 -0.22481531 -0.19456260  0.81587675
    ## [19]  0.68682298  0.44756609  0.78971253  0.64568566 -0.09904161 -2.27133861
    ## [25]  0.47485186

Write a function to find z-score.

``` r
z_scores <- function(x) {
  if (!is.numeric(x)) {
    stop("x needs to be numeric")
  } 
  
  if (length(x) < 5) {
    stop("you need at least 5 numbers to compute the z-score")
  }
  z = (x - mean(x)) / sd(x)
  
  return(z)
  
}

z_scores(x = x_vec)
```

    ##  [1] -0.83687228  0.01576465 -1.05703126  1.50152998  0.16928872 -1.04107494
    ##  [7]  0.33550276  0.59957343  0.42849461 -0.49894708  1.41364561  0.23279252
    ## [13] -0.83138529 -2.50852027  1.00648110 -0.22481531 -0.19456260  0.81587675
    ## [19]  0.68682298  0.44756609  0.78971253  0.64568566 -0.09904161 -2.27133861
    ## [25]  0.47485186

Does this always work?

- No, it doesn’t work for single numbers or character vectors, can add
  checks to return an informative error.

``` r
z_scores(x = 3)
```

    ## Error in z_scores(x = 3): you need at least 5 numbers to compute the z-score

``` r
z_scores(x = c("my", "name", "is"))
```

    ## Error in z_scores(x = c("my", "name", "is")): x needs to be numeric
