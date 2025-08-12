# PUNTA-EVAC
PUNTA-EVAC simulates the behaviors of both pedestrians and buses during an evacuation in Puntarenas, Costa Rica. The main objective is to assess the feasibility of evacuating over 8,000 residents, along with 25% of the tourist capacity, by integrating walking routes with public transportation options.
## How to Run

1. Download or clone this repository.
2. Open the file `Model.nlogo` in **NetLogo 6.4.0** or later.
3. Ensure the following files are in the same directory as `Model.nlogo`:
   - `agent-paths.xlsx` → Pre-calculated paths for agents.
   - `.nls` files (NetLogo extensions for agents, buses, tourists, residents, etc.).
   - `DatosGIS` folder → contains the GIS data (geojson).
4. In NetLogo, click `setup` to load all datasets and initialize the simulation.
5. Click `go` to start the simulation.
