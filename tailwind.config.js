function spacing () {
  const scale = Array(101)
    .fill(null)
    .map((_, i) => [i * 0.5, `${i * 0.5 * 8}px`])
  const values = Object.fromEntries(scale)
  values.px = '1px'
  values.xs = '2px'
  values.sm = '4px'
  return values
}

function opacity () {
  const scale = Array(21)
    .fill(null)
    .map((_, i) => [i * 5, Math.round(i * 0.05 * 100) / 100])
  const values = Object.fromEntries(scale)
  return values
}

module.exports = {
  content: [
    './app/views/**/*.html',
    './app/views/**/*.html.erb',
    './app/views/**/*.svg',
    './app/views/**/*.svg.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    container: {
      center: true,
      padding: '16px'
    },
    spacing: spacing(),

    extend: {
      maxWidth: spacing(),
      fontSize: {
        xxs: '0.625rem'
      },
      opacity: opacity()
    }
  },
  plugins: [
    require('@tailwindcss/forms')
  ],
}
