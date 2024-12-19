console.log("main.js!!");

const ATTRIBUTION = '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors';
const ACCESS_TOKEN = "アクセストークン";

$(document).ready(()=>{
	console.log("Ready");

	// Leaflet
	// 大垣駅の緯度経度
	const ogaki=[35.366978775556916,136.617820969011];
	const gifu=[35.409768000000014,136.757668];//岐阜駅
	const nagoya=[35.150729135070634,136.98147650000004];//名古屋
	const nichibi=[35.38393899999999,136.608351];//日本ビジネス専門学校



	// マップを使う
	const map=L.map("mapid").setView(nichibi,16);
	// マーカーを出す
	L.marker(nichibi).addTo(map).bindPopup("Hello OpenStreetMap!!").openPopup();
	// マップにの設定
	L.tileLayer("http://{s}.tile.osm.org/{z}/{x}/{y}.png",{
		attribution: ATTRIBUTION,//著作権表記
		accessToken: ACCESS_TOKEN,//アクセストークン
		id: "mapbox/streets-v11"//マップの種類
	}).addTo(map);//マップを表示
});