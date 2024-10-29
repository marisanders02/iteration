Iteration and List Columns
================
Mari Sanders
2024-10-24

# Lists

``` r
l <- list(
  vec_numeric = 1:4, 
  unif_sample = runif(100), 
  mat = matrix(1:8, nrow = 2, ncol = 4, byrow = TRUE), 
  summary = summary(rnorm(1000))
)

l$mat
```

    ##      [,1] [,2] [,3] [,4]
    ## [1,]    1    2    3    4
    ## [2,]    5    6    7    8

``` r
l[["mat"]][1,3]
```

    ## [1] 3

``` r
l[[4]]
```

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ## -3.10865 -0.67760 -0.01411 -0.01148  0.63979  3.62190

``` r
list_norm <- 
  list(
    a = rnorm(20, 0, 5), 
    b = rnorm(20, 4, 5),
    c = rnorm(20, 0, 10), 
    d = rnorm(20, 4, 10)
  )

list_norm[["b"]]
```

    ##  [1]  6.2528871 10.1361739  5.6335963  0.9950896 11.5356208  2.1195362
    ##  [7]  5.5830782  3.8646219  2.1685357  6.6398491  3.9523020  2.6580270
    ## [13]  1.4124381 -2.1465954  5.1812868 -5.9795539  0.9774183 -1.0114688
    ## [19]  8.8504482  8.8567337

``` r
mean_and_sd <- function(x) {
  
  mean_x = mean(x)
  sd_x = sd(x)
  
  output_df = 
    tibble(
      mean = mean_x,
      sd = sd_x
    )
  
  return(output_df)
}
```

Take mean and sd of all samples

``` r
mean_and_sd(list_norm[["a"]])
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1 -1.22  4.22

``` r
mean_and_sd(list_norm[["b"]])
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  3.88  4.33

``` r
mean_and_sd(list_norm[["c"]])
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1 -1.25  11.3

``` r
mean_and_sd(list_norm[["d"]])
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  5.87  7.60

## For Loop

Create an output list and run a for loop

``` r
output <- vector("list", length = 4)

for (i in 1:4) {
  
  output[[i]] = mean_and_sd(list_norm[[i]])
  
}

output
```

    ## [[1]]
    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1 -1.22  4.22
    ## 
    ## [[2]]
    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  3.88  4.33
    ## 
    ## [[3]]
    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1 -1.25  11.3
    ## 
    ## [[4]]
    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  5.87  7.60

## NSDUH

``` r
url = "http://samhda.s3-us-gov-west-1.amazonaws.com/s3fs-public/field-uploads/2k15StateFiles/NSDUHsaeShortTermCHG2015.htm"

nsduh_html <- read_html(url)

marj_df <-
  nsduh_html %>% 
  html_table() %>% 
  nth(1) %>%  
  slice(-1) %>% 
  mutate(drug = "marj")

cocaine_df <-
  nsduh_html %>% 
  html_table() %>% 
  nth(4) %>%  
  slice(-1) %>% 
  mutate(drug = "cocaine")

heroin_df <- 
  nsduh_html %>% 
  html_table() %>% 
  nth(5) %>%  
  slice(-1) %>% 
  mutate(drug = "heroin")
```

Writing a function to get each table.

``` r
source("source/nsduh_table_format.R")
nsduh_df <- bind_rows(
nsduh_import(html = nsduh_html, 1, drug = "marj"),
nsduh_import(html = nsduh_html, 4, drug = "cocaine") ,
nsduh_import(html = nsduh_html,5, drug = "heroin")) 
```
