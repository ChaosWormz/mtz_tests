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
