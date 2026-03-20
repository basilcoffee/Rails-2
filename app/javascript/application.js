// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  const buttons = document.querySelectorAll(".user-button");

  buttons.forEach((button) => {
    const menu = button.nextElementSibling; // dropdown-menu が隣にある前提
    if (!menu) return;

    // 既存イベントを消す（安全のためクローンを作る）
    const newButton = button.cloneNode(true);
    button.replaceWith(newButton);

    newButton.addEventListener("click", (e) => {
      e.preventDefault();
      menu.classList.toggle("active");
    });
  });
});
