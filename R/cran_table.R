contains_github <- function(x) {
  grepl("github\\.com", x)
}

format_cran_table <- function(x) {
  # NOTE: newlines were observed in some columns of the cran dataframe, these
  # make it difficult to save the dataframe to a .tsv and then reimport it.
  # I suspect this might be due to a bug in `readr::write_tsv`. To get around
  # it, we just convert all whitespace to single-spaces.

  remove_dup_cols <- function(df) df[, !duplicated(colnames(df))]
  collapse_ws <- function(x) gsub("[ \t\r\n]+", " ", x)

  # - Remove any columns that have duplicate names
  # - Convert column names to tidier versions of them (dots / whitespace to
  # underscores, snake_case)
  # - Strip repeated whitespace
  # - Convert all whitespace characters to single-space
  x %>%
    remove_dup_cols() %>%
    tibble::as_tibble() %>%
    janitor::clean_names() %>%
    dplyr::mutate_if(is.character, collapse_ws)
}

import_github_cran_table <- function() {
  # code modified from https://juliasilge.com/blog/mining-cran-description/

  # Download a table containing all the DESCRIPTION fields for the packages on
  # CRAN
  # - then remove duplicated fields
  # - turn it into a tibble
  # - and filter to keep only packages that have a github repo

  # read
  raw_cran <- tools::CRAN_package_db()

  # format & restrict to github repos
  format_cran_table(raw_cran) %>%
    dplyr::filter(contains_github(.data[["url"]]) | contains_github(.data[["bug_reports"]]))
}