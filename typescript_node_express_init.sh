 #! /bin/sh
#  git
git init

# 除外ファイル
{
    echo "node_modules"
    echo "typescript_node_express_init.sh"
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
npm install --save-dev eslint  @typescript-eslint/eslint-plugin @typescript-eslint/parser
# prettier
npm install --save-dev prettier eslint-config-prettier
# eslint設定ファイル
{
    echo '{'
    echo  '"parser": "@typescript-eslint/parser",'
    echo  '"plugins": ['
    echo  '"@typescript-eslint"'
    echo  '],'
    echo  '"extends": ['
    echo    '"plugin:@typescript-eslint/recommended",'
    echo    '"prettier",'
    echo    '"prettier/@typescript-eslint",'
    echo  ']'
    echo '}'
} > .eslintrc
# prettier設定
echo "{}"> .prettierrc.json
touch .prettierignore

# 除外設定
/dist　>> .prettierignore
node_modules >> .prettierignore
package.json >> .prettierignore
package-lock.json >> .prettierignore
tsconfig.json >> .prettierignore

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
touch .env

npm install --save-dev @types/express body-parser

# 絶対使うであろうライブラリを追加
npm i date-fns uuid
npm i --save-dev @types/uuid

# スクリプト追加
npm set-script test "jest"
npm set-script dev "ts-node-dev --files src/index.ts"
npm set-script dev clean "rimraf dist/*.js"
npm set-script tsc "tsc"
npm set-script tsc:check "tsc --noEmit"
npm set-script lint "eslint ./src/**/*.ts --fix"
npm set-script check "npm-run-all lint tsc:check"
npm set-script build "npm-run-all clean lint tsc"
npm set-script start "node ./dist/index.js"


npm i --save-dev husky
npm set-script prepare "husky install"
npm run prepare

npx husky add .husky/pre-commit "npm run check"
npx husky add .husky/pre-push "npm run test"


echo "***add this line to package.json***"
echo '"main":"dist/index.js",'

echo '***add below option to CompileOptions of tsconfig.json***'
echo ' "outDir": "./dist",'

echo '***add below option to tsconfig.json***'
echo  '"include": ["src/**/*"],'
echo '"exclude": ["node_modules"]'

mkdir dist
mkdir src

echo "console.log('this is test message')" > ./src/index.ts

echo 'please use chmod -R command to change permission to 777'

