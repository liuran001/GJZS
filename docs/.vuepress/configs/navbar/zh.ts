import type { NavbarConfig } from '@vuepress/theme-default'

export const zh: NavbarConfig = [
  {
    text: '下载',
    link: '/Download/',
  },
  {
    text: '更新日志',
    link: '/Changelog/',
  },
  {
    text: '支持',
    link: '/Support/',
  },
  {
    text: '友情链接',
    children: [
      {
        text: '作者个人主页',
        link: 'https://bdovo.xyz',
      },
      {
        text: '作者个人博客',
        link: 'https://blog.qqcn.xyz',
      },
      {
        text: '服务器状态查看',
        link: 'https://status.qqcn.xyz',
      },
      {
        text: '倾城极速',
        link: 'https://qcjs.cc/',
      },
    ],
  },
]
