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
        link: 'https://bdovo.cc',
      },
      {
        text: '倾城极速机场',
        link: 'https://qcjs.cc/',
      },
    ],
  },
]
