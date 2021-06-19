const path = require('path');
const glob = require('glob');
const TerserPlugin = require('terser-webpack-plugin');
const CssMinimizerPlugin = require('css-minimizer-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = (env, options) => {
  const devMode = options.mode !== 'production';

  return {
    optimization: {
      minimizer: [
        new TerserPlugin({ cache: true, parallel: true, sourceMap: devMode }),
        new CssMinimizerPlugin(),
      ]
    },
    entry: {
      './js/app.js': glob.sync('./vendor/**/*.js').concat(['./js/app.tsx'])
    },
    output: {
      filename: 'app.js',
      path: path.resolve(__dirname, '../priv/static/js')
    },
    devtool: devMode ? 'source-map' : undefined,
    module: {
      rules: [
        {
          test: /\.tsx?$/,
          exclude: /node_modules/,
          use: 'ts-loader'
        },
        {
          test: /\.css$/,
          use: ['style-loader', 'css-loader', 'postcss-loader']
        }
      ]
    },
    plugins: [
      new CopyWebpackPlugin({
        patterns: [{ from: 'static/', to: '../' }]
      })
    ],
    resolve: {
      extensions: ['.ts', '.tsx', '.js', '.jsx']
    }
  }
};
