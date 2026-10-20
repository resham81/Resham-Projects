import { useEffect, useMemo, useState } from 'react'
import { AnimatePresence, motion, useReducedMotion } from 'framer-motion'
import HeroVisual from './components/HeroVisual'
import { CERTIFICATIONS, PROFILE, PROJECTS, SKILLS } from './data/projects'

function useScrolled(threshold = 12) {
  const [scrolled, setScrolled] = useState(false)
  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > threshold)
    onScroll()
    window.addEventListener('scroll', onScroll, { passive: true })
    return () => window.removeEventListener('scroll', onScroll)
  }, [threshold])
  return scrolled
}

export default function App() {
  const scrolled = useScrolled()
  const reduceMotion = useReducedMotion()
  const [activeSkill, setActiveSkill] = useState('all')
  const [openId, setOpenId] = useState(null)

  const filtered = useMemo(() => {
    if (activeSkill === 'all') return PROJECTS
    const skill = SKILLS.find((s) => s.id === activeSkill)
    if (!skill) return PROJECTS
    return PROJECTS.filter((p) =>
      p.tech.some((t) => skill.match.some((m) => t.toLowerCase() === m.toLowerCase())),
    )
  }, [activeSkill])

  const fadeUp = reduceMotion
    ? {}
    : {
        initial: { opacity: 0, y: 24 },
        animate: { opacity: 1, y: 0 },
        transition: { duration: 0.7, ease: [0.22, 1, 0.36, 1] },
      }

  return (
    <>
      <a className="skip-link" href="#about">
        Skip to about
      </a>

      <header className={`nav ${scrolled ? 'scrolled' : ''}`}>
        <div className="site-shell nav-inner">
          <a className="nav-mark" href="#top">
            Resham <span>Furqan</span>
          </a>
          <nav aria-label="Primary">
            <ul className="nav-links">
              <li>
                <a href="#about">About</a>
              </li>
              <li>
                <a href="#work">Work</a>
              </li>
              <li>
                <a href="#certs">Certs</a>
              </li>
              <li>
                <a href="#contact">Contact</a>
              </li>
            </ul>
          </nav>
        </div>
      </header>

      <main id="top">
        <section className="hero site-shell" aria-label="Introduction">
          <motion.div className="hero-copy" {...fadeUp}>
            <p className="hero-kicker">{PROFILE.role}</p>
            <h1 className="hero-name">
              Resham
              <br />
              <em>Furqan</em>
            </h1>
            <p className="hero-line">{PROFILE.tagline}</p>
            <div className="hero-actions">
              <a className="btn btn-primary" href="#about">
                About me
              </a>
              <a className="btn btn-ghost" href="#work">
                View projects
              </a>
            </div>
          </motion.div>

          <HeroVisual />
        </section>

        <section id="about" className="about">
          <div className="site-shell about-grid">
            <h2 className="about-lead">
              Curious builder with a systems mind and a design eye.
            </h2>
            <div className="about-body">
              <p>
                I enjoy work that spans the stack — full-stack development,
                network architecture, system-level programming, and
                user-centered design.
              </p>
              <p>
                Comfortable across Python, C, SQL, Linux/Unix, AWS, Cisco
                networking, and Figma. This site collects my projects and
                certifications so recruiters can explore the real work.
              </p>
            </div>
          </div>
        </section>

        <section id="work">
          <div className="site-shell">
            <div className="section-head">
              <h2 className="section-title">Selected projects</h2>
              <p className="section-note">
                Filter by skill, then open a project for the story, stack, and
                links. Source lives in my public GitHub archive.
              </p>
            </div>

            <div
              className="skill-rail work-skills"
              role="group"
              aria-label="Filter projects by skill"
            >
              <button
                type="button"
                className="skill-btn"
                aria-pressed={activeSkill === 'all'}
                onClick={() => setActiveSkill('all')}
              >
                All work
              </button>
              {SKILLS.map((skill) => (
                <button
                  key={skill.id}
                  type="button"
                  className="skill-btn"
                  aria-pressed={activeSkill === skill.id}
                  onClick={() =>
                    setActiveSkill((prev) => (prev === skill.id ? 'all' : skill.id))
                  }
                >
                  {skill.label}
                </button>
              ))}
            </div>

            <div className="project-list">
              <AnimatePresence mode="popLayout">
                {filtered.length === 0 ? (
                  <motion.p
                    key="empty"
                    className="empty-state"
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    exit={{ opacity: 0 }}
                  >
                    No projects match that skill yet — try another filter.
                  </motion.p>
                ) : (
                  filtered.map((project, index) => {
                    const open = openId === project.id
                    return (
                      <motion.article
                        key={project.id}
                        className={`project-item ${open ? 'open' : ''}`}
                        layout={!reduceMotion}
                        initial={reduceMotion ? false : { opacity: 0, y: 12 }}
                        animate={{ opacity: 1, y: 0 }}
                        exit={{ opacity: 0, y: -8 }}
                        transition={{ duration: 0.35 }}
                      >
                        <button
                          type="button"
                          className="project-trigger"
                          aria-expanded={open}
                          onClick={() =>
                            setOpenId((prev) =>
                              prev === project.id ? null : project.id,
                            )
                          }
                        >
                          <span className="project-index">
                            {String(index + 1).padStart(2, '0')}
                          </span>
                          <span className="project-title-row">
                            <h3 className="project-title">{project.title}</h3>
                            <span className="project-meta">
                              {project.highlight} · {project.course}
                            </span>
                          </span>
                          <span className="project-year">{project.year}</span>
                        </button>

                        <AnimatePresence initial={false}>
                          {open && (
                            <motion.div
                              className="project-panel"
                              key="panel"
                              initial={
                                reduceMotion
                                  ? { height: 'auto' }
                                  : { height: 0, opacity: 0 }
                              }
                              animate={{ height: 'auto', opacity: 1 }}
                              exit={
                                reduceMotion
                                  ? { height: 0 }
                                  : { height: 0, opacity: 0 }
                              }
                              transition={{ duration: 0.35, ease: [0.22, 1, 0.36, 1] }}
                            >
                              <div className="project-panel-inner">
                                <p>{project.description}</p>
                                <div className="tech-row">
                                  {project.tech.map((t) => (
                                    <span key={t}>{t}</span>
                                  ))}
                                </div>
                                <div className="project-links">
                                  <a
                                    className="btn btn-primary"
                                    href={project.repoUrl}
                                    target="_blank"
                                    rel="noreferrer"
                                  >
                                    View on GitHub
                                  </a>
                                  {project.demo && (
                                    <a
                                      className="btn btn-ghost"
                                      href={project.demo}
                                      target="_blank"
                                      rel="noreferrer"
                                    >
                                      {project.demoLabel || 'Open demo'}
                                    </a>
                                  )}
                                </div>
                              </div>
                            </motion.div>
                          )}
                        </AnimatePresence>
                      </motion.article>
                    )
                  })
                )}
              </AnimatePresence>
            </div>
          </div>
        </section>

        <section id="certs" className="certs">
          <div className="site-shell">
            <div className="section-head">
              <h2 className="section-title">Certifications</h2>
              <p className="section-note">
                Industry credentials across low-code, Linux administration,
                networking, cloud, and applied AI.
              </p>
            </div>
            <ul className="cert-list">
              {CERTIFICATIONS.map((cert, index) => (
                <li key={cert.title} className="cert-item">
                  <span className="cert-index">
                    {String(index + 1).padStart(2, '0')}
                  </span>
                  <div className="cert-copy">
                    <h3>{cert.title}</h3>
                    <p>{cert.detail}</p>
                  </div>
                  <span className="cert-org">{cert.org}</span>
                </li>
              ))}
            </ul>
          </div>
        </section>

        <section className="contact" id="contact">
          <div className="site-shell">
            <div className="contact-box">
              <div>
                <h2>Let’s connect</h2>
                <p>
                  Based in {PROFILE.location}. Open to internships,
                  collaboration, and conversations about software, systems, and
                  thoughtful product design.
                </p>
                <ul className="contact-details">
                  <li>
                    <span>Email</span>
                    <a href={PROFILE.emailHref}>{PROFILE.email}</a>
                  </li>
                  <li>
                    <span>Phone</span>
                    <a href={PROFILE.phoneHref}>{PROFILE.phone}</a>
                  </li>
                  <li>
                    <span>GitHub</span>
                    <a href={PROFILE.githubUser} target="_blank" rel="noreferrer">
                      github.com/resham81
                    </a>
                  </li>
                  <li>
                    <span>LinkedIn</span>
                    <a href={PROFILE.linkedin} target="_blank" rel="noreferrer">
                      resham-furqan
                    </a>
                  </li>
                </ul>
              </div>
              <div className="contact-actions">
                <a className="btn btn-primary" href={PROFILE.emailHref}>
                  Email me
                </a>
                <a className="btn btn-ghost" href={PROFILE.phoneHref}>
                  Call / WhatsApp
                </a>
                <a
                  className="btn btn-ghost"
                  href={PROFILE.linkedin}
                  target="_blank"
                  rel="noreferrer"
                >
                  LinkedIn
                </a>
                <a
                  className="btn btn-ghost"
                  href={PROFILE.githubUser}
                  target="_blank"
                  rel="noreferrer"
                >
                  GitHub
                </a>
              </div>
            </div>
          </div>
        </section>
      </main>

      <footer className="site-shell footer">
        <span>© {new Date().getFullYear()} Resham Furqan</span>
      </footer>
    </>
  )
}
