//---------- external shield generator
//generates an energy field that loops around any built up area in space (is useless inside) halts movement and airflow, is blocked by walls, windows, airlocks etc

/obj/machinery/shield_gen/external
	name = "hull shield generator"
	var/global/list/blockedturfs =  list(
		/turf/space,
		/turf/simulated/floor/outdoors/grass/sif/virgo3b,
		/turf/simulated/mineral/virgo3b, //Mountains around tether versus mountain at tether.
		/turf/simulated/floor/maglev/virgo3b,
		/turf/simulated/floor/tiled/techfloor/grid/virgo3b,
		/turf/simulated/floor/virgo3b,
		/turf/simulated/floor/tiled/steel_dirty/virgo3b,
		/turf/simulated/open/virgo3b,
		/turf/simulated/mineral/floor/virgo3b,
		/turf/simulated/sky,
	)		//For Future additions to exterior tiles, add them on this list.
	
/obj/machinery/shield_gen/external/advanced
	name = "advanced hull shield generator"
	desc = "A machine that generates a field of energy optimized for blocking meteorites when activated.  This version comes with a more efficent shield matrix."
	energy_conversion_rate = 0.0012

//Search for space turfs within range that are adjacent to a simulated turf.
/obj/machinery/shield_gen/external/get_shielded_turfs_on_z_level(var/turf/gen_turf)
	var/list/out = list()

	if (!gen_turf)
		return

	var/turf/T
	for (var/x_offset = -field_radius; x_offset <= field_radius; x_offset++)
		for (var/y_offset = -field_radius; y_offset <= field_radius; y_offset++)
			T = locate(gen_turf.x + x_offset, gen_turf.y + y_offset, gen_turf.z)
			if (is_type_in_list(T,blockedturfs))
				if(!T.noshield)
					//check neighbors of T
					for(var/i in orange(1, T))
						if(istype(i, /turf/simulated) && !is_type_in_list(i,blockedturfs))
							out += T
							break
	return out
