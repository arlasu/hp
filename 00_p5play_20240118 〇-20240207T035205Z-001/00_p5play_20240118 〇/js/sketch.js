let cvs;// キャンバス
let player;//プレイヤー
let enemyGroup;//敵グループ
let score =0;
let lastScoreUpdateTime=0;

function updateScoreDisplay(){
	document.getElementById("scoreDisplay").innerText = "Score:"+score;
}

function setup(){
	// キャンバスの準備
	cvs = new Canvas(480, 320);
	world.gravity.y = 0;// 重力
	frameRate(60);// フレームレート

	//プレイヤーの準備 
	player=new Sprite(100,100);//x,y座標
	player.width=32;//幅
	player.height=32;//高さ
	player.color="Purple"//色
	player.image="./assets/reimu_good_01.png";//画像
	player.collider="dynamic"//物理演算有効

	// 敵グループ
	enemyGroup=new Group();

	// 敵を10個配置
	for(let i=0; i<10; i++){
		// 敵
		let x = random(width);
		let y = random(height);
		let enemy = new enemyGroup.Sprite(x, y);
		enemy.width = 30;
		enemy.height = 30;
		enemy.color = "aqua";
		enemy.image = "./assets/marisa_good_01.png";// 画像を設定する
		enemy.vel.x = random(-1, 1);// ランダムに移動
		enemy.vel.y = random(-1, 1);
	}

	// スコアの初期化
	score=0;
	lastScoreUPDateTime=millis();
}

function draw(){
	background("silver");// 背景色

	if (keyIsPressed){
		if (keyCode === ENTER){
			resetGame();
		}
	}

	// 左キー
	if(kb.presses("left")){//左キー
		player.vel.x=-2;//左に移動
		player.vel.y=0//これを入れると正確に行く
	}
	// TODO: 上,右,下キーを実装してください!!
	// 右キー
	if(kb.presses("right")){
		player.vel.x=2;//右に行く
		player.vel.y=0//これを入れると正確に行く
	}
	// 上キー
	if(kb.presses("up")){
		player.vel.y=-2;//上に行く
		player.vel.x=0//これを入れると正確に行く
	}
	// 下キー
	if(kb.presses("down")){
		player.vel.y=2;//
		player.vel.x=0//これを入れると正確に行く
	}

	player.update();

	// 右から出たら左へ
	if(width < player.x){
		player.x=0
	}
	// TODO: 左から出たら右へ
	if(0 > player.x){
		player.x=width
	}
	// 下から出たら上へ
	if(height < player.y){
		player.y=0
	}
	// 上から出たら下へ
	if(0 > player.y){
		player.y=height
	}
	// 敵とplayerの判定
	player.collides(enemyGroup, (a, b)=>{
		noLoop();//ゲームの停止(ゲームオーバー)
	});
		// 画面外判定
		for(let enemy of enemyGroup){
			if(enemy.x < 0) enemy.x = width;// 左から出たら右へ
			if(enemy.y < 0) enemy.y = height;// 上から出たら下へ
			if(width < enemy.x) enemy.x = 0;// 右から出たら左へ
			if(height < enemy.y) enemy.y = 0;// 下から出たら上へ
		}
		// フレームカウンタを使って64フレームおきに敵を配置
		if(frameCount%64 == 0){
		let x = random(width);
		let y = random(height);
		let enemy = new enemyGroup.Sprite(x, y);
		enemy.width = 30;
		enemy.height = 30;
		enemy.color = "aqua";
		enemy.image = "./assets/marisa_good_01.png";// 画像を設定する
		enemy.vel.x = random(-1, 1);// ランダムに移動
		enemy.vel.y = random(-1, 1);
	}
	// スコアの更新
	updateScoreDisplay();

	// スコアの更新(10秒ごとに+10)
	if(millis() - lastScoreUpdateTime > 1000){
		score +=10;
		lastScoreUpdateTime = millis();
	}
}

function updateScoreDisplay(){
	// scoreDisplay要素を取得
	let scoreDisplay= document.getElementById("scoreDisplay");

	// スコアを表示
	scoreDisplay.innerText = "Score:" +score;

	// スコアの色文字を設定(例: 白色)
	scoreDisplay.style.color = "black";
}

function resetGame(){
	player.x=100;
	player.y=100;

	enemyGroup.clear();

	for(let i=0; i < 10; i++){
	let x = random(width);
	let y =random(height);
	let enemy =new enemyGroup.Sprite(x,y);
	enemy.width=30;
	enemy.height=30;
	enemy.color="aqua";
	enemy.image="./assets/marisa_good_01.png";
	enemy.vel.x=random(-1,1);
	enemy.vel.y=random(-1,1);
	}

	// スコアをリセット
	score=0;
	lastScoreUpdateTime = millis();
}




