import { defineConfig } from 'vitepress'
import zh_CN from './zh_CN'

export default defineConfig({
    locales: {
        root: {
            label: '简体中文',
            lang: zh_CN.lang,
            themeConfig: zh_CN.themeConfig,
            description: zh_CN.description
        }
    }
})
