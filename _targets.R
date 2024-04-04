# Load packages
library(targets)
library(tarchetypes)

tar_option_set(
  packages = c("mapbaltimore")
)

tar_source()

tar_plan(

  baltimore_property_src = arcgislayers::arc_read(
    "https://geodata.baltimorecity.gov/egis/rest/services/CityView/Realproperty/MapServer/0",
    name_repair = janitor::make_clean_names,
    crs = 3857
  ),
  baltimore_property = mapbaltimore::format_property_data(
    data = baltimore_property_src
  ),
  baltimore_property_out = readr::write_rds(
    baltimore_property,
    here::here(
      "output",
      "baltimore_property.rds"
    )
  ),

  # baltimore_cama_src = arcgislayers::arc_read(
  #   "https://geodata.md.gov/imap/rest/services/PlanningCadastre/MD_ComputerAssistedMassAppraisal/MapServer/1",
  #   where = "JURSCODE LIKE 'BACI'",
  #   name_repair = janitor::make_clean_names,
  #   crs = 3857
  # ),
  # baltimore_cama = mapmaryland::format_parcel_data(baltimore_cama_src),

  baltimore_parcels_src = arcgislayers::arc_read(
    "https://geodata.md.gov/imap/rest/services/PlanningCadastre/MD_ParcelBoundaries/MapServer/0",
    where = "JURSCODE LIKE 'BACI'",
    name_repair = janitor::make_clean_names,
    crs = 3857
  ),
  baltimore_parcels = mapmaryland::format_parcel_data(baltimore_parcels_src),
  baltimore_parcels_out = readr::write_rds(
    baltimore_parcels,
    here::here(
      "output",
      "baltimore_parcels.rds"
    )
  ),

  baltimore_hmt_2023 = arcgislayers::arc_read(
    "https://geodata.baltimorecity.gov/egis/rest/services/Housing/dmxBoundaries3/MapServer/40",
    crs = 3857
  ),
  baltimore_hmt_2023_out = readr::write_rds(
    baltimore_hmt_2023,
    here::here(
      "output",
      "baltimore_hmt_2023.rds"
    )
  ),

  baltimore_vbn = arcgislayers::arc_read(
    "https://geodata.baltimorecity.gov/egis/rest/services/Housing/dmxLandPlanning/MapServer/34",
    crs = 3857
  ),
  baltimore_vbn_out = readr::write_rds(
    baltimore_vbn,
    here::here(
      "output",
      "baltimore_vbn.rds"
    )
  )

)
