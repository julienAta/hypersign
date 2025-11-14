module.exports = {
  plugins: [
    require('daisyui')
  ],
  daisyui: {
    themes: [
      {
        docuseal: {
          'color-scheme': 'light',
          primary: '#6366f1',
          secondary: '#f3f4f6',
          accent: '#eef0f8',
          neutral: '#1f2937',
          'base-100': '#fefefe',
          'base-200': '#f9fafb',
          'base-300': '#ededef',
          'base-content': '#000000',
          '--rounded-btn': '1.4rem',
          '--tab-border': '2px',
          '--tab-radius': '1.4rem'
        }
      }
    ]
  }
}
