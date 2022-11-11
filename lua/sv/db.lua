Citizen.CreateThread(function()
    MySQL.Sync.execute([[
        CREATE TABLE IF NOT EXISTS `sprays` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `x` float(8,4) NOT NULL,
            `y` float(8,4) NOT NULL,
            `z` float(8,4) NOT NULL,
            `rx` float(8,4) NOT NULL,
            `ry` float(8,4) NOT NULL,
            `rz` float(8,4) NOT NULL,
            `scale` float(8,4) NOT NULL,
            `text` varchar(32) NOT NULL,
            `font` varchar(32) NOT NULL,
            `color` int(3) NOT NULL,
            `interior` int(3) NOT NULL,
            `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
            PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
    ]])

    local sprayExists = MySQL.Sync.fetchScalar([[
        SELECT count(*) FROM items WHERE name='spray'
    ]])
    local sprayRemoverExists = MySQL.Sync.fetchScalar([[
        SELECT count(*) FROM items WHERE name='spray_remover'
    ]])

    if sprayExists == 0 then
        MySQL.Sync.execute([[
            INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('spray',	'Spray',	1,	1,	1);
        ]])
    end

    if sprayRemoverExists == 0 then
        MySQL.Sync.execute([[
            INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('spray_remover',	'Spray Remover',	1,	1,	1);
        ]])
    end
end)