#' @seealso [filter_unimproved_parcels()]
#' @importFrom dplyr filter
filter_improved_parcels <- function(parcel_data,
                                    unimproved_parcels = NULL) {
  unimproved_parcels <- unimproved_parcels %||% filter_unimproved_parcels(data)

  parcel_data |>
    dplyr::filter(
      !(objectid %in% unimproved_parcels$objectid),
      !(acctid %in% unimproved_parcels$acctid)
    )
}

