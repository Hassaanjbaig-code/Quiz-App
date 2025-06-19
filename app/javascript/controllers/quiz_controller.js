import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quiz"
export default class extends Controller {
  static values = { 
    totalquiz: Number,
    currentquiz: Number,
    optionSelected: { type: String, default: "" },
  };
  
  connect() {
    this.removePrevious(this.currentquizValue);
    const next = document.querySelector("#next");
    next.disabled = true;
    next.classList.remove('cursor-pointer');
  }

  // Handle radio toggle
  toggle(e) {
    const nextButton = document.querySelector("#next");
    if (e.target.checked) {
      nextButton.disabled = false;
      nextButton.classList.add("cursor-pointer");
      // Only use the Stimulus value, remove the regular property
      localStorage.setItem("userAnswer", e.target.value)
    }
  }
  
  // Push answer and redirect on "Next"
  async disableButton(e) {
    const nextButton = document.querySelector("#next");
    const optionValue = localStorage.getItem('userAnswer');
    if (optionValue) {
      let data = {
        quizs: {
          answer: optionValue
        }
      }
      
      let result = await fetch(nextButton.dataset.url, {
        method: "POST",
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").content
        },
        body: JSON.stringify(data)
      });
      
      const response = await result.json();
      localStorage.removeItem("userAnswer")
      
      if (response.status == 200) {
        window.location.href = nextButton.dataset.nexturl  
      }
    } else {
      console.log("No option selected");
    }
  }
  
  removePrevious(currentPosition) {
    const previous = document.getElementById("previous");
    if (this.totalquizValue !== 0 && currentPosition === 0) {
      previous?.remove();
    }
  }
}
