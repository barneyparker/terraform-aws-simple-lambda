/**
 * @file index.mjs
 */

/**
 * Lambda handler.
 *
 * @param  {object}  event  Incoming Event object
 * @return {boolean}        true
 */
export const handler = (event) => {
  console.log(JSON.stringify(event, null, 2))
  return true
}