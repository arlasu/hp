// おみくじの種類と結果
const omikujiResults = [
    { type: "大吉", description: "今日は素晴らしい日です！", image: "./images/daikichi.png" },
    { type: "中吉", description: "良いことがあるでしょう。", image: "./images/chukichi.png" },
    { type: "小吉", description: "少しの幸運があります。", image: "./images/shokichi.png" },
    { type: "末吉", description: "運が良くなりそうです。", image: "./images/suekichi.png" },
    { type: "凶", description: "注意が必要です。", image: "./images/kyo.png" },
    { type: "大凶", description: "今日は慎重に行動しましょう。", image: "./images/daikyo.png" }
];

// おみくじを引く関数
function drawOmikuji() {
    const randomIndex = Math.floor(Math.random() * omikujiResults.length);
    const result = omikujiResults[randomIndex];
    displayResult(result);
}

// 結果を表示する関数
function displayResult(result) {
    const resultContainer = document.getElementById("omikujiResult");
    const imageContainer = document.getElementById("omikujiImage");

    // 結果を表示
    resultContainer.innerHTML = `
        <h2>${result.type}</h2>
        <p>${result.description}</p>
    `;

    // 画像を表示
    imageContainer.innerHTML = `
        <img src="${result.image}" alt="${result.type}" class="img-fluid" style="max-width: 200px;">
    `;
}
