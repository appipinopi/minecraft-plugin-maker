package plugin;

import org.bukkit.plugin.java.JavaPlugin;
import java.util.logging.Logger;

/**
 * プラグインのメインクラス
 */
public class Main extends JavaPlugin {

    private static final Logger LOGGER = Logger.getLogger("Minecraft");

    @Override
    public void onEnable() {
        // プラグインが有効化されたときの処理
        LOGGER.info("MyExamplePlugin が有効化されました！");
    }

    @Override
    public void onDisable() {
        // プラグインが無効化されたときの処理
        LOGGER.info("MyExamplePlugin が無効化されました。");
    }
}
