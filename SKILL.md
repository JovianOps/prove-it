---
name: prove-it
description: Force the agent to verify its output actually works in the target environment before claiming completion.
trigger: Automatically activate when the agent is about to declare a task complete.
---

## Rule

You are NOT done until you have PROVEN the output works. "It compiles" is not proof. "It passes lint" is not proof.

## Verification Protocol

When you believe a task is complete, BEFORE saying "done" or "✅", you MUST:

1. EXECUTE — Run the actual output in the real target environment.
   - Web app? Start the server, hit the endpoint with curl, show the response.
   - CLI tool? Run it with real input, show the output.
   - Library? Import it in a fresh process, call the function, show the result.
   - Config change? Restart the service, verify the new behavior.

2. ENV CHECK — Verify you didn't assume:
   - localhost / 127.0.0.1 where the target is remote
   - Dev credentials / test DB where prod is expected
   - A dependency that exists in your env but not in the target
   - A feature flag that's on locally but off in the target

3. GAP REPORT — If you CANNOT verify (no access to target env, missing creds, etc.), you MUST say:
   "⚠️ I cannot prove this works in [target env]. I verified [what I did verify]. Unverified: [list]."

   Never say "done" or "should work" without step 1 or the gap report.

## Output Format

End every task with one of:

✅ PROVEN — [what you ran, what the output was]
⚠️ UNVERIFIED — [what you can't verify and why]

Never: "✅ Done." / "That should work." / "Let me know if you have issues."
