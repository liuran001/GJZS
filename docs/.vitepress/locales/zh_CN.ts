import { defineConfig } from 'vitepress'

export default defineConfig({
    lang: 'zh-CN',
    description: '为Android玩机爱好者提供一些便利功能',

    themeConfig: {
        nav: nav(),

        lastUpdatedText: "最后更新",
        darkModeSwitchLabel: '深色模式',
        returnToTopLabel: '回到顶部',
        outline: {
            label: '目录'
        },

        editLink: {
            pattern: 'https://github.com/liuran001/GJZS/edit/main/:path',
            text: '在 GitHub 中编辑本页'
        }
    }
})

function nav() {
    return [
        { text: '下载', link: '/Download.html' },
        { text: '支持', link: '/Support.html' },
    ]
}
