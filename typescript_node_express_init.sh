 #! /bin/sh
#  git
git init

# 除外ファイル
{
    echo "node_modules/"
    echo "typescript_webpack_init.sh"
    echo ".env"
    echo "dist"
} > .gitignore

# nodeプロジェクト初期化
npm init -y

# typescript関連
npm install --save-dev typescript ts-node ts-node-dev

# tsc初期化
./node_modules/.bin/tsc --init

# eslint
npm isntall --save-dev eslint  @typescript-eslint/eslint-plugin @typescript-eslint/parser @typescript-eslint
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


npm install --save express  dotenv
npm install --save-dev @types/express body-parser
echo "***add below commands to package.json***"
echo '"main":"dist/index.js",'
echo '"test":"jest",'
echo '"dev":"ts-node-dev --files src/index.ts",'
echo '"clean": "rimraf dist/*.js",'
echo '"tsc": "tsc",'
echo '"tsc:check": "tsc --noEmit",'
echo '"lint": "eslint ./src/**/*.ts --fix",'
echo '"check": "npm-run-all lint tsc:check",'
echo '"build": "npm-run-all clean lint tsc",'
echo '"start": "node ./dist/index.js"'

echo '***add below option to CompileOptions of tsconfig.json***'
echo ' "outDir": "./dist",'

echo '***add below option to tsconfig.json***'
echo  '"include": ["src/**/*"],'
echo '"exclude": ["node_modules"]'

mkdir dist
mkdir src

echo "console.log('this is test message')" > ./src/index.ts

echo 'please use chmod -R command to change permission to 777'

