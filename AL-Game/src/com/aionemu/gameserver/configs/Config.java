/**
 * This file is part of Aion-Lightning <aion-lightning.org>.
 *
 *  Aion-Lightning is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Aion-Lightning is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details. *
 *  You should have received a copy of the GNU General Public License
 *  along with Aion-Lightning.
 *  If not, see <http://www.gnu.org/licenses/>.
 */
package com.aionemu.gameserver.configs;

import com.aionemu.commons.configs.CommonsConfig;
import com.aionemu.commons.configs.DatabaseConfig;
import com.aionemu.commons.configuration.ConfigurableProcessor;
import com.aionemu.commons.utils.PropertiesUtils;
import com.aionemu.gameserver.configs.administration.AdminConfig;
import com.aionemu.gameserver.configs.administration.DeveloperConfig;
import com.aionemu.gameserver.configs.main.*;
import com.aionemu.gameserver.configs.network.IPConfig;
import com.aionemu.gameserver.configs.network.NetworkConfig;
import com.aionemu.gameserver.utils.Util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Properties;

import java.net.InetSocketAddress;

/**
 * @author Nemesiss, SoulKeeper
 */
public class Config {

    protected static final Logger log = LoggerFactory.getLogger(Config.class);

    /**
     * Initialize all configs in com.aionemu.gameserver.configs package
     */
    public static void load() {
        try {
            Properties myProps = null;
            try {
                log.info("Loading: mygs.properties");
                myProps = PropertiesUtils.load("./config/mygs.properties");
            } catch (Exception e) {
                log.info("No override properties found");
            }

            // Administration
            Util.printSection("ADMINISTRATION");
            String administration = "./config/administration";

            Properties[] adminProps = PropertiesUtils.loadAllFromDirectory(administration);
            PropertiesUtils.overrideProperties(adminProps, myProps);

            ConfigurableProcessor.process(AdminConfig.class, adminProps);
            log.info("Loading: " + administration + "/admin.properties");

            ConfigurableProcessor.process(DeveloperConfig.class, adminProps);
            log.info("Loading: " + administration + "/developer.properties");

            // Main
            Util.printSection("MAIN");
            String main = "./config/main";

            Properties[] mainProps = PropertiesUtils.loadAllFromDirectory(main);
            PropertiesUtils.overrideProperties(mainProps, myProps);

            ConfigurableProcessor.process(AgentFightConfig.class, mainProps);
            log.info("Loading: " + main + "/agentfight.properties");

            ConfigurableProcessor.process(AIConfig.class, mainProps);
            log.info("Loading: " + main + "/ai.properties");

            ConfigurableProcessor.process(AutoGroupConfig.class, mainProps);
            log.info("Loading: " + main + "/autogroup.properties");

            ConfigurableProcessor.process(BaseConfig.class, mainProps);
            log.info("Loading: " + main + "/base.properties");

            ConfigurableProcessor.process(BeritraConfig.class, mainProps);
            log.info("Loading: " + main + "/beritra.properties");
            
            ConfigurableProcessor.process(CompositionConfig.class, mainProps);
            log.info("Loading: " + main + "/composition.properties");
            
            ConfigurableProcessor.process(ConquerorProtectorConfig.class, mainProps);
            log.info("Loading: " + main + "/conqueror.properties");
			
            ConfigurableProcessor.process(DualBoxConfig.class, mainProps);
            log.info("Loading: " + main + "/DualBoxConfig.properties");

            ConfigurableProcessor.process(CommonsConfig.class, mainProps);
            log.info("Loading: " + main + "/commons.properties");

            ConfigurableProcessor.process(CacheConfig.class, mainProps);
            log.info("Loading: " + main + "/cache.properties");

            ConfigurableProcessor.process(CleaningConfig.class, mainProps);
            log.info("Loading: " + main + "/cleaning.properties");
			
			ConfigurableProcessor.process(CompositionConfig.class, mainProps);
            log.info("Loading: " + main + "/composition.properties");

            ConfigurableProcessor.process(CraftConfig.class, mainProps);
            log.info("Loading: " + main + "/craft.properties");

            ConfigurableProcessor.process(CustomConfig.class, mainProps);
            log.info("Loading: " + main + "/custom.properties");

            ConfigurableProcessor.process(DropConfig.class, mainProps);
            log.info("Loading: " + main + "/drop.properties");

            ConfigurableProcessor.process(EnchantsConfig.class, mainProps);
            log.info("Loading: " + main + "/enchants.properties");

            ConfigurableProcessor.process(EventsConfig.class, mainProps);
            log.info("Loading: " + main + "/events.properties");

            ConfigurableProcessor.process(FallDamageConfig.class, mainProps);
            log.info("Loading: " + main + "/falldamage.properties");

            ConfigurableProcessor.process(FastTrackConfig.class, mainProps);
            log.info("Loading: " + main + "/fasttrack.properties");

            ConfigurableProcessor.process(GSConfig.class, mainProps);
            log.info("Loading: " + main + "/gameserver.properties");

            ConfigurableProcessor.process(GeoDataConfig.class, mainProps);
            log.info("Loading: " + main + "/geodata.properties");

            ConfigurableProcessor.process(GroupConfig.class, mainProps);
            log.info("Loading: " + main + "/group.properties");

            ConfigurableProcessor.process(HousingConfig.class, mainProps);
            log.info("Loading: " + main + "/housing.properties");

            ConfigurableProcessor.process(HTMLConfig.class, mainProps);
            log.info("Loading: " + main + "/html.properties");

            ConfigurableProcessor.process(InGameShopConfig.class, mainProps);
            log.info("Loading: " + main + "/ingameshop.properties");

            ConfigurableProcessor.process(LegionConfig.class, mainProps);
            log.info("Loading: " + main + "/legion.properties");

            ConfigurableProcessor.process(LoggingConfig.class, mainProps);
            log.info("Loading: " + main + "/logging.properties");

            ConfigurableProcessor.process(MembershipConfig.class, mainProps);
            log.info("Loading: " + main + "/membership.properties");

            ConfigurableProcessor.process(MoltenusConfig.class, mainProps);
            log.info("Loading: " + main + "/moltenus.properties");

            ConfigurableProcessor.process(NameConfig.class, mainProps);
            log.info("Loading: " + main + "/name.properties");

            ConfigurableProcessor.process(PeriodicSaveConfig.class, mainProps);
            log.info("Loading: " + main + "/periodicsave.properties");

            ConfigurableProcessor.process(PlayerTransferConfig.class, mainProps);
            log.info("Loading: " + main + "/playertransfer.properties");

            ConfigurableProcessor.process(PricesConfig.class, mainProps);
            log.info("Loading: " + main + "/prices.properties");

            ConfigurableProcessor.process(PunishmentConfig.class, mainProps);
            log.info("Loading: " + main + "/punishment.properties");

            ConfigurableProcessor.process(RankingConfig.class, mainProps);
            log.info("Loading: " + main + "/ranking.properties");

            ConfigurableProcessor.process(RateConfig.class, mainProps);
            log.info("Loading: " + main + "/rates.properties");

            ConfigurableProcessor.process(SecurityConfig.class, mainProps);
            log.info("Loading: " + main + "/security.properties");

            ConfigurableProcessor.process(ShutdownConfig.class, mainProps);
            log.info("Loading: " + main + "/shutdown.properties");

            ConfigurableProcessor.process(SiegeConfig.class, mainProps);
            log.info("Loading: " + main + "/siege.properties");

            ConfigurableProcessor.process(ThreadConfig.class, mainProps);
            log.info("Loading: " + main + "/thread.properties");

            ConfigurableProcessor.process(WeddingsConfig.class, mainProps);
            log.info("Loading: " + main + "/weddings.properties");

            ConfigurableProcessor.process(WorldConfig.class, mainProps);
            log.info("Loading: " + main + "/world.properties");

            // Network
            Util.printSection("NETWORK");
            String network = "./config/network";

            Properties[] networkProps = PropertiesUtils.loadAllFromDirectory(network);
            PropertiesUtils.overrideProperties(networkProps, myProps);

            log.info("Loading: " + network + "/database.properties");
            ConfigurableProcessor.process(DatabaseConfig.class, networkProps);

            log.info("Loading: " + network + "/network.properties");
            ConfigurableProcessor.process(NetworkConfig.class, networkProps);

            override_configs();

        } catch (Exception e) {
            log.error("Can't load gameserver configuration: ", e);
            throw new Error("Can't load gameserver configuration: ", e);
        }

        IPConfig.load();
    }

    public static void override_configs()
    {
        // Network Config Overrides
        NetworkConfig.GAME_PORT = EnvToInt("GAMESERVER_PORT", NetworkConfig.GAME_PORT);
        NetworkConfig.GAME_BIND_ADDRESS = EnvToString("GAMESERVER_BIND_ADDRESS", NetworkConfig.GAME_BIND_ADDRESS);
        NetworkConfig.MAX_ONLINE_PLAYERS = EnvToInt("MAX_ONLINE_PLAYERS", NetworkConfig.MAX_ONLINE_PLAYERS);
        NetworkConfig.LOGIN_ADDRESS = new InetSocketAddress("localhost", EnvToInt("GAME_PORT", 9014));
        

        // Custom Config Overrides
        CustomConfig.CHALLENGE_TASKS_ENABLED = EnvToBoolean("CHALLENGE_TASKS_ENABLED", CustomConfig.CHALLENGE_TASKS_ENABLED);
        CustomConfig.FATIGUE_SYSTEM_ENABLED = EnvToBoolean("FATIGUE_SYSTEM_ENABLED", CustomConfig.FATIGUE_SYSTEM_ENABLED);
        CustomConfig.PREMIUM_NOTIFY = EnvToBoolean("PREMIUM_NOTIFY", CustomConfig.PREMIUM_NOTIFY);
        CustomConfig.SPEAKING_BETWEEN_FACTIONS = EnvToBoolean("SPEAKING_BETWEEN_FACTIONS", CustomConfig.SPEAKING_BETWEEN_FACTIONS);
        CustomConfig.ENABLE_SIMPLE_2NDCLASS = EnvToBoolean("ENABLE_SIMPLE_2NDCLASS", CustomConfig.ENABLE_SIMPLE_2NDCLASS);
        CustomConfig.SKILL_CHAIN_TRIGGERRATE = EnvToBoolean("SKILL_CHAIN_TRIGGERRATE", CustomConfig.SKILL_CHAIN_TRIGGERRATE);
        CustomConfig.LEVEL_TO_WHISPER = EnvToInt("LEVEL_TO_WHISPER", CustomConfig.LEVEL_TO_WHISPER);
        CustomConfig.LEVEL_TO_SEARCH = EnvToInt("LEVEL_TO_SEARCH", CustomConfig.LEVEL_TO_SEARCH);
        CustomConfig.UNSTUCK_DELAY = EnvToInt("UNSTUCK_DELAY", CustomConfig.UNSTUCK_DELAY);
        CustomConfig.DYE_PRICE = EnvToInt("DYE_PRICE", CustomConfig.DYE_PRICE);
        
        // GSConfig Overrides
        GSConfig.LOGINSERVER_NAME = EnvToString("LOGINSERVER_DATABASE", GSConfig.LOGINSERVER_NAME);
        GSConfig.SERVER_COUNTRY_CODE = EnvToInt("SERVER_COUNTRY_CODE", GSConfig.SERVER_COUNTRY_CODE);
        GSConfig.PLAYER_MAX_LEVEL = EnvToInt("PLAYER_MAX_LEVEL", GSConfig.PLAYER_MAX_LEVEL);
        GSConfig.SERVER_MOTD_DISPLAYREV = EnvToBoolean("SERVER_MOTD_DISPLAYREV", GSConfig.SERVER_MOTD_DISPLAYREV);
        GSConfig.CHARACTER_CREATION_MODE = EnvToInt("CHARACTER_CREATION_MODE", GSConfig.CHARACTER_CREATION_MODE);
        GSConfig.LANG = EnvToString("SERVER_LANG", GSConfig.LANG);
        GSConfig.TIME_ZONE_ID = EnvToString("TIME_ZONE_ID", GSConfig.TIME_ZONE_ID);
        GSConfig.ENABLE_CHAT_SERVER = EnvToBoolean("ENABLE_CHAT_SERVER", GSConfig.ENABLE_CHAT_SERVER);
        
        // Rates Overrides
        RateConfig.XP_RATE = EnvToFloat("XP_RATE", RateConfig.XP_RATE);
        RateConfig.PREMIUM_XP_RATE = EnvToFloat("PREMIUM_XP_RATE", RateConfig.PREMIUM_XP_RATE);
        RateConfig.VIP_XP_RATE = EnvToFloat("VIP_XP_RATE", RateConfig.VIP_XP_RATE);
        RateConfig.GROUPXP_RATE = EnvToFloat("GROUPXP_RATE", RateConfig.GROUPXP_RATE);
        RateConfig.PREMIUM_GROUPXP_RATE = EnvToFloat("PREMIUM_GROUPXP_RATE", RateConfig.PREMIUM_GROUPXP_RATE);
        RateConfig.VIP_GROUPXP_RATE = EnvToFloat("VIP_GROUPXP_RATE", RateConfig.VIP_GROUPXP_RATE);
        RateConfig.QUEST_XP_RATE = EnvToFloat("QUEST_XP_RATE", RateConfig.QUEST_XP_RATE);
        RateConfig.PREMIUM_QUEST_XP_RATE = EnvToFloat("PREMIUM_QUEST_XP_RATE", RateConfig.PREMIUM_QUEST_XP_RATE);
        RateConfig.VIP_QUEST_XP_RATE = EnvToFloat("VIP_QUEST_XP_RATE", RateConfig.VIP_QUEST_XP_RATE);
        RateConfig.GATHERING_XP_RATE = EnvToFloat("GATHERING_XP_RATE", RateConfig.GATHERING_XP_RATE);
        RateConfig.PREMIUM_GATHERING_XP_RATE = EnvToFloat("PREMIUM_GATHERING_XP_RATE", RateConfig.PREMIUM_GATHERING_XP_RATE);
        RateConfig.VIP_GATHERING_XP_RATE = EnvToFloat("VIP_GATHERING_XP_RATE", RateConfig.VIP_GATHERING_XP_RATE);
        RateConfig.CRAFTING_XP_RATE = EnvToFloat("CRAFTING_XP_RATE", RateConfig.CRAFTING_XP_RATE);
        RateConfig.PREMIUM_CRAFTING_XP_RATE = EnvToFloat("PREMIUM_CRAFTING_XP_RATE", RateConfig.PREMIUM_CRAFTING_XP_RATE);
        RateConfig.VIP_CRAFTING_XP_RATE = EnvToFloat("VIP_CRAFTING_XP_RATE", RateConfig.VIP_CRAFTING_XP_RATE);
        RateConfig.QUEST_KINAH_RATE = EnvToFloat("QUEST_KINAH_RATE", RateConfig.QUEST_KINAH_RATE);
        RateConfig.PREMIUM_QUEST_KINAH_RATE = EnvToFloat("PREMIUM_QUEST_KINAH_RATE", RateConfig.PREMIUM_QUEST_KINAH_RATE);
        RateConfig.VIP_QUEST_KINAH_RATE = EnvToFloat("VIP_QUEST_KINAH_RATE", RateConfig.VIP_QUEST_KINAH_RATE);
        RateConfig.QUEST_AP_RATE = EnvToFloat("QUEST_AP_RATE", RateConfig.QUEST_AP_RATE);
        RateConfig.PREMIUM_QUEST_AP_RATE = EnvToFloat("PREMIUM_QUEST_AP_RATE", RateConfig.PREMIUM_QUEST_AP_RATE);
        RateConfig.VIP_QUEST_AP_RATE = EnvToFloat("VIP_QUEST_AP_RATE", RateConfig.VIP_QUEST_AP_RATE);
        RateConfig.QUEST_GP_RATE = EnvToFloat("QUEST_GP_RATE", RateConfig.QUEST_GP_RATE);
        RateConfig.PREMIUM_QUEST_GP_RATE = EnvToFloat("PREMIUM_QUEST_GP_RATE", RateConfig.PREMIUM_QUEST_GP_RATE);
        RateConfig.VIP_QUEST_GP_RATE = EnvToFloat("VIP_QUEST_GP_RATE", RateConfig.VIP_QUEST_GP_RATE);
        RateConfig.DROP_RATE = EnvToFloat("DROP_RATE", RateConfig.DROP_RATE);
        RateConfig.PREMIUM_DROP_RATE = EnvToFloat("PREMIUM_DROP_RATE", RateConfig.PREMIUM_DROP_RATE);
        RateConfig.VIP_DROP_RATE = EnvToFloat("VIP_DROP_RATE", RateConfig.VIP_DROP_RATE);
        
        // DB Overrides
        DatabaseConfig.DATABASE_URL = "jdbc:mysql://" + EnvToString("DB_HOST", "localhost") + ":" + EnvToInt("DB_PORT", 3306) + "/" + EnvToString("GAMESERVER_DATABASE", "al_server_gs") + "?useUnicode=true&characterEncoding=UTF-8";
        DatabaseConfig.DATABASE_USER = EnvToString("DB_USER", DatabaseConfig.DATABASE_USER);
        DatabaseConfig.DATABASE_PASSWORD = EnvToString("DB_PASS", DatabaseConfig.DATABASE_PASSWORD);
    }

    /**
     * Reload all configs in com.aionemu.gameserver.configs package
     */
    public static void reload() {
        try {
            Properties myProps = null;
            try {
                log.info("Loading: mygs.properties");
                myProps = PropertiesUtils.load("./config/mygs.properties");
            } catch (Exception e) {
                log.info("No override properties found");
            }

            // Administration
            String administration = "./config/administration";

            Properties[] adminProps = PropertiesUtils.loadAllFromDirectory(administration);
            PropertiesUtils.overrideProperties(adminProps, myProps);

            ConfigurableProcessor.process(AdminConfig.class, adminProps);
            log.info("Reload: " + administration + "/admin.properties");

            ConfigurableProcessor.process(DeveloperConfig.class, adminProps);
            log.info("Reload: " + administration + "/developer.properties");

            // Main
            String main = "./config/main";

            Properties[] mainProps = PropertiesUtils.loadAllFromDirectory(main);
            PropertiesUtils.overrideProperties(mainProps, myProps);

            ConfigurableProcessor.process(AgentFightConfig.class, mainProps);
            log.info("Reload: " + main + "/agentfight.properties");

            ConfigurableProcessor.process(AIConfig.class, mainProps);
            log.info("Reload: " + main + "/ai.properties");

            ConfigurableProcessor.process(AutoGroupConfig.class, mainProps);
            log.info("Reload: " + main + "/autogroup.properties");

            ConfigurableProcessor.process(BaseConfig.class, mainProps);
            log.info("Reload: " + main + "/base.properties");

            ConfigurableProcessor.process(BeritraConfig.class, mainProps);
            log.info("Reload: " + main + "/beritra.properties");
            
            ConfigurableProcessor.process(CompositionConfig.class, mainProps);
            log.info("Reload: " + main + "/composition.properties");
            
            ConfigurableProcessor.process(ConquerorProtectorConfig.class, mainProps);
            log.info("Reload: " + main + "/conqueror.properties");

            ConfigurableProcessor.process(DualBoxConfig.class, mainProps);
            log.info("Reload: " + main + "/DualBoxConfig.properties");
			
            ConfigurableProcessor.process(CommonsConfig.class, mainProps);
            log.info("Reload: " + main + "/commons.properties");

            ConfigurableProcessor.process(CacheConfig.class, mainProps);
            log.info("Reload: " + main + "/cache.properties");
			
			ConfigurableProcessor.process(CompositionConfig.class, mainProps);
            log.info("Reload: " + main + "/composition.properties");

            ConfigurableProcessor.process(CraftConfig.class, mainProps);
            log.info("Reload: " + main + "/craft.properties");

            ConfigurableProcessor.process(CustomConfig.class, mainProps);
            log.info("Reload: " + main + "/custom.properties");

            ConfigurableProcessor.process(DropConfig.class, mainProps);
            log.info("Reload: " + main + "/drop.properties");

            ConfigurableProcessor.process(EnchantsConfig.class, mainProps);
            log.info("Reload: " + main + "/enchants.properties");

            ConfigurableProcessor.process(EventsConfig.class, mainProps);
            log.info("Reload: " + main + "/events.properties");

            ConfigurableProcessor.process(FallDamageConfig.class, mainProps);
            log.info("Reload: " + main + "/falldamage.properties");

            ConfigurableProcessor.process(FastTrackConfig.class, mainProps);
            log.info("Reload: " + main + "/fasttrack.properties");

            ConfigurableProcessor.process(GSConfig.class, mainProps);
            log.info("Reload: " + main + "/gameserver.properties");

            ConfigurableProcessor.process(GeoDataConfig.class, mainProps);
            log.info("Reload: " + main + "/geodata.properties");

            ConfigurableProcessor.process(GroupConfig.class, mainProps);
            log.info("Reload: " + main + "/group.properties");

            ConfigurableProcessor.process(HousingConfig.class, mainProps);
            log.info("Reload: " + main + "/housing.properties");

            ConfigurableProcessor.process(HTMLConfig.class, mainProps);
            log.info("Reload: " + main + "/html.properties");

            ConfigurableProcessor.process(InGameShopConfig.class, mainProps);
            log.info("Reload: " + main + "/ingameshop.properties");

            ConfigurableProcessor.process(LegionConfig.class, mainProps);
            log.info("Reload: " + main + "/legion.properties");

            ConfigurableProcessor.process(LoggingConfig.class, mainProps);
            log.info("Reload: " + main + "/logging.properties");

            ConfigurableProcessor.process(MembershipConfig.class, mainProps);
            log.info("Reload: " + main + "/membership.properties");
            
            ConfigurableProcessor.process(MoltenusConfig.class, mainProps);
            log.info("Reload: " + main + "/moltenus.properties");
            
            ConfigurableProcessor.process(NameConfig.class, mainProps);
            log.info("Reload: " + main + "/name.properties");

            ConfigurableProcessor.process(PeriodicSaveConfig.class, mainProps);
            log.info("Reload: " + main + "/periodicsave.properties");

            ConfigurableProcessor.process(PlayerTransferConfig.class, mainProps);
            log.info("Reload: " + main + "/playertransfer.properties");

            ConfigurableProcessor.process(PricesConfig.class, mainProps);
            log.info("Reload: " + main + "/prices.properties");

            ConfigurableProcessor.process(PunishmentConfig.class, mainProps);
            log.info("Reload: " + main + "/punishment.properties");

            ConfigurableProcessor.process(RankingConfig.class, mainProps);
            log.info("Reload: " + main + "/ranking.properties");

            ConfigurableProcessor.process(RateConfig.class, mainProps);
            log.info("Reload: " + main + "/rates.properties");

            ConfigurableProcessor.process(SecurityConfig.class, mainProps);
            log.info("Reload: " + main + "/security.properties");

            ConfigurableProcessor.process(ShutdownConfig.class, mainProps);
            log.info("Reload: " + main + "/shutdown.properties");

            ConfigurableProcessor.process(SiegeConfig.class, mainProps);
            log.info("Reload: " + main + "/siege.properties");

            ConfigurableProcessor.process(ThreadConfig.class, mainProps);
            log.info("Reload: " + main + "/thread.properties");

            ConfigurableProcessor.process(WeddingsConfig.class, mainProps);
            log.info("Reload: " + main + "/weddings.properties");

            ConfigurableProcessor.process(WorldConfig.class, mainProps);
            log.info("Reload: " + main + "/world.properties");

           override_configs();

        } catch (Exception e) {
            log.error("Can't reload configuration: ", e);
            throw new Error("Can't reload configuration: ", e);
        }
    }

    public static int EnvToInt(String ENV_NAME, int defaultValue) {
        try {
          String env = System.getenv(ENV_NAME);
          return Integer.parseInt(env);
        } catch (Exception e) {
            return defaultValue;
        }
    }

    public static float EnvToFloat(String ENV_NAME, float defaultValue) {
        try {
          String env = System.getenv(ENV_NAME);
          return Float.parseFloat(env);
        } catch (Exception e) {
            return defaultValue;
        }
    }

    public static String EnvToString(String ENV_NAME, String defaultValue) {
        try {
          String env = System.getenv(ENV_NAME);
          if(!env.isEmpty()) {
            return env;
          } else {
            return defaultValue;
          }
        } catch (Exception e) {
            return defaultValue;
        }
    }

    public static boolean EnvToBoolean(String ENV_NAME, boolean defaultValue) {
        try {
          String env = System.getenv(ENV_NAME);
          if(!env.isEmpty()) {
            return env.equals("true");
          } else {
            return defaultValue;
          }
        } catch (Exception e) {
            return defaultValue;
        }
    }
}
