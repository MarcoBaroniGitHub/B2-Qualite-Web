<!-- 
  Système de gestion du contraste des couleurs pour l'accessibilité WCAG 2.0
  Ratio minimum requis: 3:1
-->

<template>
  <div class="contrast-system">
    <!-- Exemple d'utilisation du composant -->
    <section class="demo-section">
      <h1>Système de Contraste Accessible</h1>

      <!-- Composant avec validation automatique -->
      <ContrastSafeText
        text-color="#333333"
        background-color="#ffffff"
        :min-ratio="3"
        :show-debug="isDevelopment"
      >
        <p>Ce texte respecte le ratio de contraste minimum de 3:1</p>
      </ContrastSafeText>

      <!-- Exemple avec contraste insuffisant (en dev seulement) -->
      <ContrastSafeText
        text-color="#cccccc"
        background-color="#ffffff"
        :min-ratio="3"
        :show-debug="isDevelopment"
      >
        <p>⚠️ Ce texte n'a pas un contraste suffisant</p>
      </ContrastSafeText>

      <!-- Texte sur dégradé -->
      <div class="gradient-background">
        <ContrastSafeText
          text-color="#000000"
          background-color="#ffcc00"
          :min-ratio="3"
        >
          <h2>Texte sur arrière-plan en dégradé</h2>
        </ContrastSafeText>
      </div>

      <!-- Palette de couleurs accessibles -->
      <div class="color-palette">
        <h2>Palettes de couleurs accessibles</h2>
        <div class="palette-grid">
          <ColorCard
            v-for="(pair, index) in colorPairs"
            :key="index"
            :foreground="pair.fg"
            :background="pair.bg"
            :label="pair.label"
          />
        </div>
      </div>

      <!-- Testeur de contraste interactif -->
      <div class="contrast-tester">
        <h2>Testeur de contraste</h2>
        <div class="tester-controls">
          <div class="color-input">
            <label for="fg-color">Couleur du texte:</label>
            <input id="fg-color" v-model="testForeground" type="color" />
            <input v-model="testForeground" type="text" placeholder="#000000" />
          </div>

          <div class="color-input">
            <label for="bg-color">Couleur de fond:</label>
            <input id="bg-color" v-model="testBackground" type="color" />
            <input v-model="testBackground" type="text" placeholder="#ffffff" />
          </div>
        </div>

        <div class="test-result">
          <div
            class="preview"
            :style="{
              color: testForeground,
              backgroundColor: testBackground,
            }"
          >
            <p>Texte de prévisualisation</p>
            <p style="font-size: 24px; font-weight: bold">Texte en gras</p>
          </div>

          <div class="result-info">
            <p><strong>Ratio de contraste:</strong> {{ testRatio }}</p>
            <p :class="testStatus.class">
              <strong>Statut:</strong> {{ testStatus.text }}
            </p>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

// ====== UTILITAIRES DE CALCUL DE CONTRASTE ======

/**
 * Calcule la luminance relative d'une couleur selon WCAG 2.0
 */
function getLuminance(hex) {
  const rgb = hexToRgb(hex)
  if (!rgb) return 0

  const [r, g, b] = rgb.map((val) => {
    const normalized = val / 255
    return normalized <= 0.03928
      ? normalized / 12.92
      : Math.pow((normalized + 0.055) / 1.055, 2.4)
  })

  return 0.2126 * r + 0.7152 * g + 0.0722 * b
}

/**
 * Convertit une couleur hexadécimale en RGB
 */
function hexToRgb(hex) {
  const cleaned = hex.replace('#', '')
  if (cleaned.length !== 6) return null

  return [
    parseInt(cleaned.substr(0, 2), 16),
    parseInt(cleaned.substr(2, 2), 16),
    parseInt(cleaned.substr(4, 2), 16),
  ]
}

/**
 * Convertit RGB en hexadécimal
 */
function rgbToHex(rgb) {
  const match = rgb.match(/\d+/g)
  if (!match) return '#000000'

  return (
    '#' +
    match
      .slice(0, 3)
      .map((x) => parseInt(x).toString(16).padStart(2, '0'))
      .join('')
  )
}

/**
 * Calcule le ratio de contraste entre deux couleurs
 */
function getContrastRatio(foreground, background) {
  const l1 = getLuminance(foreground)
  const l2 = getLuminance(background)

  const lighter = Math.max(l1, l2)
  const darker = Math.min(l1, l2)

  return (lighter + 0.05) / (darker + 0.05)
}

/**
 * Vérifie si le contraste respecte le ratio minimum
 */
function meetsContrastRequirement(foreground, background, minRatio = 3) {
  return getContrastRatio(foreground, background) >= minRatio
}

/**
 * Trouve la couleur de fond effective d'un élément
 */
function getEffectiveBackground(element) {
  let current = element
  while (current && current !== document.body) {
    const bg = window.getComputedStyle(current).backgroundColor
    if (bg && bg !== 'rgba(0, 0, 0, 0)' && bg !== 'transparent') {
      return rgbToHex(bg)
    }
    current = current.parentElement
  }
  return '#ffffff' // Blanc par défaut
}

// ====== COMPOSANT PRINCIPAL ======

const isDevelopment = ref(process.env.NODE_ENV === 'development')

// Testeur interactif
const testForeground = ref('#000000')
const testBackground = ref('#ffffff')

const testRatio = computed(() => {
  try {
    const ratio = getContrastRatio(testForeground.value, testBackground.value)
    return ratio.toFixed(2) + ':1'
  } catch {
    return 'N/A'
  }
})

const testStatus = computed(() => {
  try {
    const ratio = getContrastRatio(testForeground.value, testBackground.value)
    if (ratio >= 7) {
      return { text: '✅ AAA (Excellent)', class: 'status-aaa' }
    } else if (ratio >= 4.5) {
      return { text: '✅ AA (Bon)', class: 'status-aa' }
    } else if (ratio >= 3) {
      return { text: '⚠️ Minimum (Acceptable)', class: 'status-min' }
    } else {
      return { text: '❌ Insuffisant', class: 'status-fail' }
    }
  } catch {
    return { text: 'Erreur', class: 'status-error' }
  }
})

// Palette de couleurs accessibles
const colorPairs = ref([
  { fg: '#000000', bg: '#ffffff', label: 'Noir sur blanc (21:1)' },
  { fg: '#ffffff', bg: '#000000', label: 'Blanc sur noir (21:1)' },
  { fg: '#0066cc', bg: '#ffffff', label: 'Bleu primaire (4.5:1)' },
  { fg: '#008000', bg: '#ffffff', label: 'Vert succès (3.9:1)' },
  { fg: '#cc0000', bg: '#ffffff', label: 'Rouge danger (5.9:1)' },
  { fg: '#8B6914', bg: '#ffffff', label: 'Orange avertissement (4.6:1)' },
  { fg: '#ffffff', bg: '#0066cc', label: 'Blanc sur bleu (4.5:1)' },
  { fg: '#ffffff', bg: '#006600', label: 'Blanc sur vert foncé (6.4:1)' },
])
</script>

<script>
// ====== COMPOSANT CONTRASTSAFETEXT ======

const ContrastSafeText = {
  name: 'ContrastSafeText',
  props: {
    textColor: {
      type: String,
      required: true,
    },
    backgroundColor: {
      type: String,
      required: true,
    },
    minRatio: {
      type: Number,
      default: 3,
    },
    showDebug: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    contrastRatio() {
      try {
        return getContrastRatio(this.textColor, this.backgroundColor)
      } catch {
        return 0
      }
    },
    isAccessible() {
      return this.contrastRatio >= this.minRatio
    },
    containerStyle() {
      return {
        backgroundColor: this.backgroundColor,
        color: this.textColor,
        padding: '1rem',
        borderRadius: '4px',
        marginBottom: '1rem',
      }
    },
  },
  template: `
    <div 
      :style="containerStyle"
      :class="{ 'contrast-warning': !isAccessible }"
    >
      <slot></slot>
      
      <div v-if="showDebug" class="contrast-debug">
        <strong>Ratio de contraste:</strong> {{ contrastRatio.toFixed(2) }}:1
        <span v-if="!isAccessible" class="warning-badge">
          ⚠️ Insuffisant (minimum: {{ minRatio }}:1)
        </span>
        <span v-else class="success-badge">
          ✓ Conforme
        </span>
      </div>
    </div>
  `,
}

// ====== COMPOSANT COLORCARD ======

const ColorCard = {
  name: 'ColorCard',
  props: {
    foreground: String,
    background: String,
    label: String,
  },
  computed: {
    ratio() {
      return getContrastRatio(this.foreground, this.background).toFixed(2)
    },
    cardStyle() {
      return {
        color: this.foreground,
        backgroundColor: this.background,
        padding: '1rem',
        borderRadius: '8px',
        border: '1px solid #ddd',
      }
    },
  },
  template: `
    <div :style="cardStyle" class="color-card">
      <p style="margin: 0; font-weight: bold;">Aa</p>
      <p style="margin: 0.5rem 0 0; font-size: 0.875rem;">{{ label }}</p>
      <p style="margin: 0.25rem 0 0; font-size: 0.75rem;">Ratio: {{ ratio }}:1</p>
    </div>
  `,
}

// Export des composants
export default {
  components: {
    ContrastSafeText,
    ColorCard,
  },
}
</script>

<style scoped>
.contrast-system {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
  font-family:
    -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue',
    Arial, sans-serif;
}

.demo-section h1 {
  color: #333;
  margin-bottom: 2rem;
}

/* Indicateur de contraste insuffisant */
.contrast-warning {
  outline: 3px dashed #ff6b6b;
  outline-offset: 2px;
}

.contrast-debug {
  margin-top: 0.75rem;
  padding: 0.5rem;
  background: rgba(255, 255, 255, 0.9);
  color: #333;
  font-size: 0.875rem;
  border-radius: 4px;
  border-left: 4px solid #0066cc;
}

.warning-badge {
  display: inline-block;
  margin-left: 0.5rem;
  padding: 0.25rem 0.5rem;
  background: #ff6b6b;
  color: white;
  border-radius: 4px;
  font-size: 0.75rem;
}

.success-badge {
  display: inline-block;
  margin-left: 0.5rem;
  padding: 0.25rem 0.5rem;
  background: #51cf66;
  color: white;
  border-radius: 4px;
  font-size: 0.75rem;
}

/* Arrière-plan en dégradé */
.gradient-background {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 2rem;
  border-radius: 8px;
  margin: 2rem 0;
}

/* Palette de couleurs */
.color-palette {
  margin: 3rem 0;
}

.color-palette h2 {
  color: #333;
  margin-bottom: 1.5rem;
}

.palette-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 1rem;
}

.color-card {
  transition: transform 0.2s;
}

.color-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

/* Testeur de contraste */
.contrast-tester {
  margin: 3rem 0;
  padding: 2rem;
  background: #f8f9fa;
  border-radius: 8px;
}

.contrast-tester h2 {
  color: #333;
  margin-bottom: 1.5rem;
}

.tester-controls {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.color-input {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.color-input label {
  font-weight: 600;
  color: #333;
}

.color-input input[type='color'] {
  width: 60px;
  height: 40px;
  border: 1px solid #ddd;
  border-radius: 4px;
  cursor: pointer;
}

.color-input input[type='text'] {
  padding: 0.5rem;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-family: monospace;
}

.test-result {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 2rem;
}

.preview {
  padding: 2rem;
  border-radius: 8px;
  border: 2px solid #ddd;
  min-height: 150px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.preview p {
  margin: 0.5rem 0;
}

.result-info {
  display: flex;
  flex-direction: column;
  justify-content: center;
  gap: 1rem;
}

.result-info p {
  margin: 0;
  font-size: 1.1rem;
}

.status-aaa {
  color: #2f9e44;
}

.status-aa {
  color: #51cf66;
}

.status-min {
  color: #fab005;
}

.status-fail {
  color: #f03e3e;
}

.status-error {
  color: #868e96;
}

/* Responsive */
@media (max-width: 768px) {
  .test-result {
    grid-template-columns: 1fr;
  }

  .tester-controls {
    grid-template-columns: 1fr;
  }
}
</style>
