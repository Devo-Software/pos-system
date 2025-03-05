import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "content"]
  static values = {
    title: String
  }

  connect() {
    // Opcional: código de inicialización si es necesario
  }

  open(event) {
    event.preventDefault()
    
    const title = event.currentTarget.dataset.modalTitle || "Modal"
    
    const modalHTML = `
      <div class="fixed inset-0 bg-gray-500 bg-opacity-75 flex items-center justify-center p-4 z-50" data-controller="modal">
        <div class="bg-white rounded-lg shadow-xl max-w-lg w-full mx-auto">
          <div class="flex items-center justify-between p-4 border-b">
            <h3 class="text-lg font-medium text-gray-900">${title}</h3>
            <button data-action="modal#close" class="text-gray-400 hover:text-gray-500">
              <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>
          <div class="p-4" id="modal-content">
            <turbo-frame id="order_type_modal" src="/pos/order_type_modal">
            </turbo-frame>
          </div>
        </div>
      </div>
    `
    
    document.body.insertAdjacentHTML('beforeend', modalHTML)
  }

  close() {
    const modalContainer = document.querySelector('.fixed.inset-0.bg-gray-500')
    if (modalContainer) {
      modalContainer.remove()
    } else {
      this.element.remove()
    }
  }
}
