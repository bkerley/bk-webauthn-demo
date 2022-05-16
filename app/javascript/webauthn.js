"use strict"

import * as webauthn_json from "@github/webauthn-json"

function arrayBufferToBase64(buf) {
  let str = String.fromCharCode(...new Uint8Array(buf))
  return btoa(str)
}

function webauthn_challenge() {
  let challenge_j = document.querySelector('script#webauthn_create_options')

  if (! (challenge_j instanceof HTMLScriptElement)) return

  let butt = document.querySelector('button#request-credential')
  let create_options = JSON.parse(challenge_j.innerHTML)
  let create_arg = {
    publicKey: create_options
  }
  let form = document.forms['new_credential']
  let els = form.elements
  butt.addEventListener('click', _e => {
    webauthn_json.create(create_arg).
      then(credentials => {
        console.log(credentials)
        els['credential_response'].value = JSON.stringify(credentials)
        for (let e of els) { e.disabled = false }
        form.submit()
      })
  })
  els['credential_name'].addEventListener('change', _e => {
    butt.disabled = (0 == _e.target.value.length)
  })
  butt.disabled = (0 == els['credential_name'].value.length)
}
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', webauthn_challenge)
} else {
  webauthn_challenge()
}
