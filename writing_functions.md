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

## New Function

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

mean_and_sd(x_vec)
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  10.6  3.33

## Check Stuff using a Simulation

``` r
sim_df <- 
  tibble(
    x = rnorm(30, 10, 5)
  )

sim_df %>% 
  summarize(
    mean = mean(x), 
    sd = sd(x)
  )
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  10.2  3.71

## Simulation Function

- Checks sample mean and standard deviation.

``` r
sim_mean_sd = function(samp_size, true_mean, true_sd) {
  sim_df <- 
  tibble(
    x = rnorm(samp_size, true_mean, true_sd)
  )
  out_df = 
    sim_df %>% 
    summarize(
      mean = mean(x), 
      sd = sd(x)
    )
  return(out_df)
}

sim_mean_sd(30, 16, 2)
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  16.2  2.06

## Revisit LoTR Words

``` r
fellowship_df <- 
  read_excel("data/LoTR_Words.xlsx", range = "B3:D6") %>% 
  mutate(movie = "fellowship") %>% 
  janitor::clean_names()
two_towers_df <- 
  read_excel("data/LoTR_Words.xlsx", range = "F3:H6") %>% 
  mutate(movie = "two_towers") %>% 
  janitor::clean_names()
return_king_df <- 
  read_excel("data/LoTR_Words.xlsx", range = "J3:L6") %>% 
  mutate(movie = "return_king") %>% 
  janitor::clean_names()
```

Using a function instead

``` r
importing_lotr <- function(range, movie) {
  movie_df <-
  read_excel("data/LoTR_Words.xlsx", range = range) %>% 
    mutate(movie = movie) %>% 
    janitor::clean_names() %>% 
    pivot_longer(
      female:male, 
      names_to = "sex",
      values_to = "words"
    ) %>% 
    select(movie, everything())
  
  return(movie_df)
}
lotr_df <- 
  bind_rows(
importing_lotr(range = "B3:D6", movie = "fellowship"),
importing_lotr(range = "F3:H6", movie = "two_towers"),
importing_lotr(range = "J3:L6", movie = "return_king"))
```

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
