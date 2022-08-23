import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log('address_controller is working!')

    this.element.addEventListener('blur', (event) => {
      var zipCode = event.target.value.replace(/\D/g, '')

      if (zipCode === "") return this.cleanZipCodeForm()

      if (!/^[0-9]{8}$/.test(zipCode)) return alert('Formato de CEP inválido!')

      fetch(`https://viacep.com.br/ws/${zipCode}/json`)
        .then(response => response.json())
        .then(data => this.setAddress(data))
    })
  }

  setAddress(data) {
    if (data.erro) {
      this.cleanZipCodeForm()
      return alert('CEP não encontrado!')
    }

    document.getElementById("order_state").value = data.uf
    document.getElementById("order_city").value = data.localidade
    document.getElementById("order_address").value = data.logradouro
  }

  cleanZipCodeForm() {
    document.getElementById("order_state").value = ''
    document.getElementById("order_city").value = ''
    document.getElementById("order_address").value = ''
  }
}
