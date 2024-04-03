#' Filter unimproved parcels
#'
#' @param data
#' @param railway_terms description
filter_unimproved_parcels <- function(parcel_data,
                                      railway_terms = c(
                                        "CANTON DEVELOPMENT COMPANY",
                                        "CSX TRANSPORTATION",
                                        "NATIONAL RAILROAD",
                                        "PENNSYLVANIA LINES"
                                      )) {
  stopifnot(
    all(rlang::has_name(
      parcel_data,
      c("ownname1", "zoning", "nfmimpvl", "objectid")
    ))
  )

  parcel_data |>
    dplyr::filter(
      stringr::str_detect(ownname1, paste0(railway_terms, collapse = "|")) |
        zoning == "OS" |
        is.na(nfmimpvl) |
        nfmimpvl == 0 |
        # Exclude Lake Montebello
        objectid == 280950 # |
      # is.na(descbldg)) & !(polydate == "2023FEB"),
      # FIXME: Should this be a running list?
      # !(acctid %in% c(
      #   "0326036543B001",
      #   "0309193948 001",
      #   "0309193948 010")),
      # !(block %in% c("6458", "6458A", "6467"))
    )
}
