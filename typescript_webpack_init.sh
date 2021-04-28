 #! /bin/sh
# まずgitの初期化
git init

# gitignore作成
{
    echo "node_modules/"
    echo "typescript_webpack_init.sh"
} > .gitignore

# nodeのプロジェクト初期化
npm init -y

# typescriptとwebpack用のローダー
npm i -D webpack webpack-cli typescript ts-loader

# typescriptの初期化
./node_modules/.bin/tsc --init
# webpackの導入
npm isntall --save-dev eslint eslint-config-prettier eslint-plugin-prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser prettier


{
    echo '{'
    echo  '"parser": "@typescript-eslint/parser",'
    echo  '"extends": ['
    echo    '"plugin:@typescript-eslint/recommended",'
    echo    '"plugin:prettier/recommended",'
    echo    '"prettier/@typescript-eslint"'
    echo  ']'
    echo '}'
} > .eslintrc

# dev用設定ファイル
{
echo "module.exports = {"
echo "  mode: 'development',"
echo "  watch: true,"
echo "    watchOptions: {"
echo "        ignored: /node_modules/"
echo "    },"
echo "  entry: './src/main.ts',"
echo "  module: {"
echo "    rules: ["
echo "      {"
echo "        test: /\.ts$/,"
echo "        use: 'ts-loader',"
echo "      },"
echo "    ],"
echo "  },"
echo "  resolve: {"
echo "    extensions: ["
echo "      '.ts', '.js',"
echo "    ],"
echo "  },"
echo "};"
} >  webpack.config.dev.js

# 本番用設定ファイル
{
echo "module.exports = {"
echo "  mode: 'production',"
echo "  watch: false,"
echo "  entry: './src/main.ts',"
echo "  module: {"
echo "    rules: ["
echo "      {"
echo "        test: /\.ts$/,"
echo "        use: 'ts-loader',"
echo "      },"
echo "    ],"
echo "  },"
echo "  resolve: {"
echo "    extensions: ["
echo "      '.ts', '.js',"
echo "    ],"
echo "  },"
echo "};"
} >  webpack.config.pro.js

# 便利なツール導入
npm install -D rimraf npm-run-all

echo "***add below commands to package.json***"
echo '"dev":"npx webpack --config webpack.config.dev.js",'
echo '"pro":"npx webpack --config webpack.config.pro.js",'
echo '"clean": "rimraf dist/*.js",'
echo '"build": "npm-run-all clean pro",'

echo '***add below option to CompileOptions of jsconfig.json***'
echo ' "outDir": "./dist",'

echo '***add below option to tsconfig.json***'
echo  '"include": ["src/**/*"],'
echo '"exclude": ["node_modules"]'

mkdir dist
mkdir src

echo "console.log('this is test message')" > ./src/main.ts

{
echo '<!DOCTYPE html>'
echo '<html lang="ja">'
echo '  <head>'
echo '    <meta charset="UTF-8" />'
echo '    <meta http-equiv="X-UA-Compatible" content="IE=edge" />'
echo '    <meta name="viewport" content="width=device-width, initial-scale=1.0" />'
echo '    <title>Document</title>'
echo '    <script src="main.js"></script>'
echo '  </head>'
echo '  <body><h1>this is test page.</h1></body>'
echo '</html>'
} > ./dist/index.html

echo 'please use chmod -R command to change permission to 777'
