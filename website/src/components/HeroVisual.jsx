import { useEffect, useRef, useState } from 'react'
import { motion, useReducedMotion } from 'framer-motion'

export default function HeroVisual() {
  const reduceMotion = useReducedMotion()
  const ref = useRef(null)
  const [offset, setOffset] = useState({ x: 0, y: 0 })

  useEffect(() => {
    if (reduceMotion) return undefined
    const node = ref.current
    if (!node) return undefined

    const onMove = (event) => {
      const rect = node.getBoundingClientRect()
      const x = (event.clientX - rect.left) / rect.width - 0.5
      const y = (event.clientY - rect.top) / rect.height - 0.5
      setOffset({ x: x * 12, y: y * 10 })
    }

    const onLeave = () => setOffset({ x: 0, y: 0 })

    node.addEventListener('pointermove', onMove)
    node.addEventListener('pointerleave', onLeave)
    return () => {
      node.removeEventListener('pointermove', onMove)
      node.removeEventListener('pointerleave', onLeave)
    }
  }, [reduceMotion])

  return (
    <motion.div
      ref={ref}
      className="hero-visual"
      aria-hidden="true"
      initial={reduceMotion ? false : { opacity: 0, y: 18 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.95, ease: [0.22, 1, 0.36, 1], delay: 0.08 }}
    >
      <div className="hero-plate">
        <span className="hero-watermark">folio</span>

        <motion.div
          className="hero-botanical"
          style={
            reduceMotion
              ? undefined
              : {
                  transform: `translate3d(${offset.x}px, ${offset.y}px, 0)`,
                }
          }
        >
          <svg
            className="hero-botanical-svg"
            viewBox="0 0 420 520"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            {/* stem */}
            <path
              className="stem"
              d="M210 480 C206 390 214 300 208 210 C204 150 212 90 210 40"
              stroke="currentColor"
              strokeWidth="1.6"
              strokeLinecap="round"
            />
            {/* left leaves */}
            <path
              className="leaf leaf-a"
              d="M208 390 C150 370 108 330 96 280 C140 285 180 320 208 350 Z"
              fill="currentColor"
            />
            <path
              className="leaf leaf-b"
              d="M207 300 C145 275 112 230 104 180 C150 190 185 240 207 265 Z"
              fill="currentColor"
            />
            <path
              className="leaf leaf-c"
              d="M208 220 C160 195 135 155 128 112 C168 125 195 170 208 192 Z"
              fill="currentColor"
            />
            {/* right leaves */}
            <path
              className="leaf leaf-d"
              d="M212 360 C275 345 318 300 330 250 C285 260 245 305 212 330 Z"
              fill="currentColor"
            />
            <path
              className="leaf leaf-e"
              d="M211 270 C278 250 318 205 328 155 C280 170 240 220 211 240 Z"
              fill="currentColor"
            />
            <path
              className="leaf leaf-f"
              d="M212 190 C262 170 292 130 300 88 C262 100 232 145 212 165 Z"
              fill="currentColor"
            />
            {/* bud tip */}
            <ellipse
              className="bud"
              cx="210"
              cy="52"
              rx="10"
              ry="16"
              fill="currentColor"
            />
            {/* fine veins */}
            <path
              d="M208 350 C175 330 145 305 120 285"
              stroke="rgba(247,242,234,0.35)"
              strokeWidth="0.8"
            />
            <path
              d="M212 330 C250 312 285 285 310 265"
              stroke="rgba(247,242,234,0.35)"
              strokeWidth="0.8"
            />
            <path
              d="M207 265 C170 245 140 215 120 190"
              stroke="rgba(247,242,234,0.28)"
              strokeWidth="0.8"
            />
          </svg>
        </motion.div>

        <div className="hero-caption">
          <span>Quiet craft</span>
          <span className="hero-caption-rule" />
          <span>Selected works</span>
        </div>
      </div>
    </motion.div>
  )
}
