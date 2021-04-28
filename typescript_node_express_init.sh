 #! /bin/sh
#  git
git init

# 除外ファイル
{
    echo "node_modules/"
    echo "typescript_webpack_init.sh"
} > .gitignore

# nodeプロジェクト初期化
npm init -y

# typescript関連
npm install --save-dev typescript ts-node ts-node-dev

# tsc初期化
./node_modules/.bin/tsc --init

# eslint
npm isntall --save-dev eslint eslint-config-prettier eslint-plugin-prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser prettier
# eslint設定ファイル
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


# 便利なツール導入
npm install -D rimraf npm-run-all

npm install --save express
npm install --save-dev @types/express body-parser
echo "***add below commands to package.json***"
echo '"main":"dist/index.js",'
echo '"dev":"ts-node-dev src/index.ts",'
echo '"clean": "rimraf dist/*.js",'
echo '"tsc": "tsc",'
echo '"build": "npm-run-all clean tsc",'
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

