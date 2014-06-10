minetest.register_privilege("tester",
        { "Player can test unreleased features.",
          give_to_singleplayer= false }
    )

local experimental_tree = {
    --- Trunk, FaceHorizotal, MainLeaderLeader
    axiom="/ FFF A FFF [&-- // b //// b //// b] F/[D-D][+D+D]",
    rules_a = "[&&TT &TTT ^^TB&TTT] // [--&&&&D][++&&&&D] // A",
    rules_b = "[^--TTTT C &&D][^----TTTT C &&D][^++TTTT C &&D][^++++TTTT C &&D]",
    rules_c = "&&//TTTC",
    rules_d = "[FF/FF/FF/FF]",
    
    trunk="default:tree",
    leaves="default:leaves",
    --leaves2="",
    --leaves2_chance = 5,
    angle=30,
    iterations=3,
    random_level=3,
    trunk_type="crossed",
    thin_branches=true
}

minetest.register_craftitem("mtz_tests:treespawner", {
    description = "Test Experimental Tree",
    inventory_image = "default_stick.png",
    on_use = function(itemstack, user, pointed_thing)
        local hasprivs = minetest.check_player_privs(user:get_player_name(), {tester=true})

        if hasprivs == true and pointed_thing.type == "node" then
            local pos = pointed_thing.above
            minetest.env:spawn_tree(pos, experimental_tree)
        end
    end
})



--added code for sapling

minetest.register_node("mtz_tests:sapling", {
	description = "MTZ Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"default_sapling.png"},
	inventory_image = "default_sapling.png",
	wield_image = "default_sapling.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	selection_box = {
	type = "fixed",
	fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
})

--abm
minetest.register_abm({
	nodenames = {"mtz_tests:sapling"},
	interval = 10,
	chance = 50,
	action = function(pos, node)
		local nu =  minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		local is_soil = minetest.get_item_group(nu, "soil")
		if is_soil == 0 then
			return
		end
		
		minetest.log("action", "A sapling grows into a tree at "..minetest.pos_to_string(pos))
minetest.env:spawn_tree(pos, experimental_tree)
	end
})
