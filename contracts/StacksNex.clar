;; StacksNex: A smart contract platform for Stacks ecosystem
;; Phase 1: Core asset management and STX/sBTC/BTC conversion functionality
;; Author: Senior Blockchain Developer
;; Date: March 31, 2025

;; Define constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))
(define-constant err-insufficient-balance (err u102))
(define-constant err-asset-not-whitelisted (err u103))
(define-constant err-invalid-params (err u104))

;; Define data maps
(define-map user-balances {user: principal, asset: (string-ascii 10)} {amount: uint})
(define-map whitelisted-assets (string-ascii 10) {active: bool, decimals: uint})
(define-map conversion-rates {from: (string-ascii 10), to: (string-ascii 10)} {rate: uint, decimals: uint})
(define-map user-settings principal {auto-stack: bool, preferred-reward: (string-ascii 10)})

;; Define data variables
(define-data-var total-volume uint u0)
(define-data-var total-users uint u0)
(define-data-var protocol-fee-percent uint u10) ;; 0.1% (with 2 decimals)

;; Initialize contract
(begin
  (map-set whitelisted-assets "STX" {active: true, decimals: u6})
  (map-set whitelisted-assets "sBTC" {active: true, decimals: u8})
  (map-set whitelisted-assets "BTC" {active: true, decimals: u8})
  
  (map-set conversion-rates {from: "STX", to: "sBTC"} {rate: u273, decimals: u8})
  (map-set conversion-rates {from: "sBTC", to: "STX"} {rate: u366300000, decimals: u8})
  (map-set conversion-rates {from: "sBTC", to: "BTC"} {rate: u100000000, decimals: u8})
  (map-set conversion-rates {from: "BTC", to: "sBTC"} {rate: u100000000, decimals: u8})
)

;; Read-only functions

(define-read-only (get-balance (user principal) (asset (string-ascii 10)))
  (default-to u0 (get amount (map-get? user-balances {user: user, asset: asset}))))

(define-read-only (is-asset-whitelisted (asset (string-ascii 10)))
  (default-to false (get active (map-get? whitelisted-assets asset))))

(define-read-only (get-conversion-rate (from-asset (string-ascii 10)) (to-asset (string-ascii 10)))
  (map-get? conversion-rates {from: from-asset, to: to-asset}))

(define-read-only (calculate-conversion (from-asset (string-ascii 10)) (to-asset (string-ascii 10)) (amount uint))
  (let ((rate-data (map-get? conversion-rates {from: from-asset, to: to-asset})))
    (if (is-some rate-data)
        (let ((rate (get rate (unwrap-panic rate-data))))
          (ok (/ (* amount rate) (pow u10 (get decimals (unwrap-panic rate-data))))))
        (err err-invalid-params))))

(define-read-only (get-user-settings (user principal))
  (default-to {auto-stack: false, preferred-reward: "STX"} (map-get? user-settings user)))

;; Public functions

(define-public (deposit (asset (string-ascii 10)) (amount uint))
  (begin
    (asserts! (is-asset-whitelisted asset) (err err-asset-not-whitelisted))
    (map-set user-balances {user: tx-sender, asset: asset} {amount: (+ (get-balance tx-sender asset) amount)})
    (var-set total-volume (+ (var-get total-volume) amount))
    (ok true)))

(define-public (withdraw (asset (string-ascii 10)) (amount uint))
  (begin
    (asserts! (is-asset-whitelisted asset) (err err-asset-not-whitelisted))
    (asserts! (>= (get-balance tx-sender asset) amount) (err err-insufficient-balance))
    (map-set user-balances {user: tx-sender, asset: asset} {amount: (- (get-balance tx-sender asset) amount)})
    (ok true)))

(define-public (convert (from-asset (string-ascii 10)) (to-asset (string-ascii 10)) (amount uint))
  (let ((converted-amount (unwrap-panic (calculate-conversion from-asset to-asset amount))))
    (asserts! (>= (get-balance tx-sender from-asset) amount) (err err-insufficient-balance))
    (map-set user-balances {user: tx-sender, asset: from-asset} {amount: (- (get-balance tx-sender from-asset) amount)})
    (map-set user-balances {user: tx-sender, asset: to-asset} {amount: (+ (get-balance tx-sender to-asset) converted-amount)})
    (ok {from-amount: amount, to-amount: converted-amount})))

(define-public (update-settings (auto-stack bool) (preferred-reward (string-ascii 10)))
  (begin
    (asserts! (is-asset-whitelisted preferred-reward) (err err-asset-not-whitelisted))
    (map-set user-settings tx-sender {auto-stack: auto-stack, preferred-reward: preferred-reward})
    (ok true)))

;; Admin functions

(define-public (update-protocol-fee (new-fee-percent uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner) (err err-owner-only))
    (asserts! (<= new-fee-percent u1000) (err err-invalid-params))
    (var-set protocol-fee-percent new-fee-percent)
    (ok true)))

(define-public (update-conversion-rate (from-asset (string-ascii 10)) (to-asset (string-ascii 10)) (rate uint) (decimals uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner) (err err-owner-only))
    (map-set conversion-rates {from: from-asset, to: to-asset} {rate: rate, decimals: decimals})
    (ok true)))

(define-public (add-whitelisted-asset (asset (string-ascii 10)) (decimals uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner) (err err-owner-only))
    (map-set whitelisted-assets asset {active: true, decimals: decimals})
    (ok true)))
