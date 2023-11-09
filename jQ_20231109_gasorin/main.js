console.log("main.js!!");

$(document).ready(()=>{
	console.log("Ready!!");

	// ガソリン代を計算する
	$("#btn_calc").click(()=>{
		console.log("計算開始!!");
		//フォーム入力から
		//ガソリン代価格
		const strA=$("#input_a").val();
		console.log("strA:",strA);
		//もし、strAが空文字だったら...
		if(strA === ""){
			console.log("strAは空文字ですね!!");
			$("#msg_info").text("ガソリン価格を入力してください。");
			return;//ここで停止
		}
		
		// TODO: 残りの入力欄2つを実装してください。
		//走行距離 #input_b
		const strB=$("#input_b").val();
		console.log("strB:",strB)
		//
		if(strB === ""){
			console.log("strBは空文字だよ!!");
			$("#msg_info").text("走行距離を入力してください");
			return;//ここで停止
		}
		//#input_c
		const strC=$("#input_c").val();
		console.log("strC:",strC);
		//
		if(strC === ""){
			console.log("strCは空文字だよ!!");
			$("#msg_info").text("車の燃費を入力してください");
			return;//ここで停止
		}

		// ここまで来てたら、空文字は無いという事!!
		console.log("全データ入力済み",strA,strB,strC);

		// 文字から数値に変換
		const numA=parseInt(strA);
		// 数値かどうかチェック
		if(Number.isInteger(numA) === false){
			console.log("numAは数値じゃないよ!!");
			$("#msg_info").text("ガソリン価格を入力してください");
			return;//ここで停止
		}

		// strB
		// 文字から数値に変換
		const numB=parseInt(strB);
		// 数値かどうかチェック
		if(Number.isInteger(numB) === false){
		console.log("numBは数値じゃないよ!!");
		$("#msg_info").text("走行距離を入力してください");
		return;//ここで停止
			}
		
		// strC
		// 文字から数値に変換
		const numC=parseInt(strC);
		// 数値かどうかチェック
		if(Number.isInteger(numC) === false){
		console.log("numCは数値じゃないよ!!");
		$("#msg_info").text("車の燃費を入力してください");
		return;//ここで停止
			}
		
		// ここまで来たら、データはすべて無効です!!
		console.log("エラー無しなので計算するよ!");

		// TODO: #msg_resultにガソリン代を表示する事!!
		const gasorin = strA * strB / strC;
		$("#msg_result").text(strA* strB/ strC);
		
	});
});