 #! /bin/sh
# まずgitの初期化
git init

# gitignore作成
{
    echo "node_modules/"
    echo "typescript_webpack_init.sh"
    echo ".env"
} > .gitignore

# nodeのプロジェクト初期化
npm init -y

# typescriptとwebpack用のローダー
npm i -D webpack webpack-cli typescript ts-loader

# 環境変数
npm i dotenv

touch .env

# typescriptの初期化
./node_modules/.bin/tsc --init
# webpackの導入
npm isntall --save-dev eslint eslint-config-prettier eslint-plugin-prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser prettier

# eslint
npm install --save-dev eslint  @typescript-eslint/eslint-plugin @typescript-eslint/parser
# eslint設定ファイル
{
    echo '{'
    echo  '"parser": "@typescript-eslint/parser",'
    echo  '"plugins": ['
    echo  '"@typescript-eslint"'
    echo  '],'
    echo  '"extends": ['
    echo    '"plugin:@typescript-eslint/recommended",'
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

# テストフレームワーク
npm i jest ts-jest @types/jest

# jest設定ファイル
{
    echo 'export default {'
    echo  'coverageProvider: "v8",'
    echo  'roots: ["<rootDir>/src"],'
    echo  'transform: { "^.+\\.(ts|tsx)$": "ts-jest" },'
    echo '};'
} > jest.config.ts

npm set-script dev "npx webpack --config webpack.config.dev.js"
npm set-script lint "eslint ./src/**/*.ts --fix"
npm set-script tsc:check "tsc --noEmit"
npm set-script check "npm-run-all lint tsc:check"
npm set-script pro "npx webpack --config webpack.config.pro.js"
npm set-script clean "rimraf dist/*.js"
npm set-script build "npm-run-all clean pro"


echo '***add below option to CompileOptions of jsconfig.json***'
echo ' "outDir": "./dist",'

echo '***add below option to tsconfig.json***'
echo  '"include": ["src/**/*"],'
echo '"exclude": ["node_modules"]'


# 絶対使うであろうライブラリを追加
npm i date-fns uuid
npm i --save-dev @types/uuid

npm i --save-dev husky
npm set-script prepare "husky install"
npm run prepare

npx husky add .husky/pre-commit "npm run check"
npx husky add .husky/pre-push "npm run test"

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
